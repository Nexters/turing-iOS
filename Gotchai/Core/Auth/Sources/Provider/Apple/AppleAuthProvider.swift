//
//  AppleAuthProvider.swift
//  Auth
//

import Combine
import AuthenticationServices
import UIKit

public final class AppleAuthProvider: NSObject, AuthProvider, @unchecked Sendable {
    // AuthProvider 요구사항
    public let kind: AuthProviderKind = .apple
    
    // 내부 상태
    private var signInSubject: PassthroughSubject<UserSession, Error>?
    private var authorizationController: ASAuthorizationController?
    
    public override init() {}
    
    deinit {
        // 혹시 남아있다면 안전 종료
        signInSubject?.send(completion: .failure(AuthError.signInFailed(reason: "Authorization controller deinitialized")))
        signInSubject = nil
        authorizationController = nil
    }
    
    // MARK: - AuthProvider
    public func signIn() -> AnyPublisher<UserSession, Error> {
        // 동시 로그인 시도 방지
        if signInSubject != nil {
            return Fail(error: AuthError.signInFailed(reason: "Sign-in already in progress")).eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<UserSession, Error>()
        self.signInSubject = subject
        
        // 요청 구성
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        self.authorizationController = controller
        
        // ✅ UI 호출은 반드시 메인에서
        let perform = { controller.performRequests() }
        if Thread.isMainThread { perform() } else { DispatchQueue.main.async(execute: perform) }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<Void, Error> {
        // 애플은 OS 레벨 계정이라 별도 로그아웃 개념이 없음 → 앱 내부 세션만 정리하면 됨
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteUser() -> AnyPublisher<Void, Error> {
        // 애플 계정 연결 해제는 서버 사이드에서 토큰 폐기/탈퇴 처리로 수행하는 편
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthProvider: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let subject = signInSubject else {
            // 이미 해제된 경우
            authorizationController = nil
            return
        }
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            subject.send(completion: .failure(AuthError.signInFailed(reason: "Invalid credential")))
            authorizationController = nil
            signInSubject = nil
            return
        }
        
        let userId = appleIDCredential.user
        let name = [appleIDCredential.fullName?.givenName, appleIDCredential.fullName?.familyName]
            .compactMap { $0 }
            .joined(separator: " ")
        let email = appleIDCredential.email
        let token = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) ?? ""
        
        let session = UserSession(
            id: userId,
            name: name.isEmpty ? "Unknown" : name,
            email: email ?? "Unknown",
            token: token
        )
        
        // 결과 방출은 메인에서 보장
        let complete = {
            subject.send(session)
            subject.send(completion: .finished)
            self.authorizationController = nil
            self.signInSubject = nil
        }
        if Thread.isMainThread { complete() } else { DispatchQueue.main.async(execute: complete) }
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        guard let subject = signInSubject else {
            authorizationController = nil
            return
        }
        
        let complete = {
            subject.send(completion: .failure(AuthError.signInFailed(reason: error.localizedDescription)))
            self.authorizationController = nil
            self.signInSubject = nil
        }
        if Thread.isMainThread { complete() } else { DispatchQueue.main.async(execute: complete) }
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthProvider: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // 활성 윈도우 탐색 (메인에서)
        let findAnchor: () -> ASPresentationAnchor = {
            for scene in UIApplication.shared.connectedScenes {
                guard scene.activationState == .foregroundActive,
                      let windowScene = scene as? UIWindowScene else { continue }
                if let key = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    return key
                }
                if let first = windowScene.windows.first {
                    return first
                }
            }
            return ASPresentationAnchor()
        }
        
        if Thread.isMainThread {
            return findAnchor()
        } else {
            var anchor = ASPresentationAnchor()
            DispatchQueue.main.sync { anchor = findAnchor() }
            return anchor
        }
    }
}
