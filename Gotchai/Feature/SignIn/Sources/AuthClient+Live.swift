//
//  AuthClient+Live.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import AuthenticationServices
import ComposableArchitecture

extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient { type in
        let clientLive = AuthClientLive()
        
        switch type {
        case .apple:
            return try await clientLive.loginWithApple()
        case .kakao:
            return .init(id: "kakao:123456789", name: "nickname")   // dummy
        }
    }
}

public final class AuthClientLive {
    private let appleSignInDelegate = AppleSignInDelegate()
    
    func loginWithApple() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            Task { @MainActor in
                // 1. Apple 로그인 요청 생성
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest()
                
                // 2. 요청할 사용자 정보 범위 설정
                request.requestedScopes = []
                
                // 3. 인증 컨트롤러 생성
                let controller = ASAuthorizationController(authorizationRequests: [request])
                
                // 4. Delegate 연결 및 Continuation 전달
                self.appleSignInDelegate.continuation = continuation
                controller.delegate = self.appleSignInDelegate
                
                // 5. 로그인 요청 실행
                controller.performRequests()
            }
        }
    }
}

private class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    var continuation: CheckedContinuation<User, Error>?
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let idToken = credential.user
            // TODO: idToken keychain에 저장
            
            let user = User(id: "", name: credential.fullName?.givenName ?? "no name")
            continuation?.resume(returning: user)
        } else {
            continuation?.resume(throwing: AuthError.appleLoginFailed)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        continuation?.resume(throwing: error)
    }
}
