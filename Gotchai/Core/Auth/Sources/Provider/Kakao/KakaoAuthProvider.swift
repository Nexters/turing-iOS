//
//  KakaoAuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Foundation

// Kakao SDK 초기화는 앱 생애주기에서 1번만
private enum KakaoSDKBootstrap {
    static var didInit = false
    static func ensureInitialized(appKey: String) {
        guard !didInit else { return }
        KakaoSDK.initSDK(appKey: appKey)
        didInit = true
    }
}

public final class KakaoAuthProvider: AuthProvider {
    public let kind: AuthProviderKind = .kakao
    private let appKey: String
    
    public init(appKey: String) {
        self.appKey = appKey
        KakaoSDKBootstrap.ensureInitialized(appKey: appKey)
    }
    
    public func signIn() -> AnyPublisher<UserSession, Error> {
        Future { promise in
            // promise를 메인에서 안전하게 완료
            let completeOnMain: (Result<UserSession, Error>) -> Void = { result in
                if Thread.isMainThread { promise(result) }
                else { DispatchQueue.main.async { promise(result) } }
            }
            
            let loginHandler: (OAuthToken?, Error?) -> Void = { token, error in
                if let error = error {
                    return completeOnMain(.failure(AuthError.signInFailed(reason: error.localizedDescription)))
                }
                guard let token = token else {
                    return completeOnMain(.failure(AuthError.signInFailed(reason: "No token received")))
                }
                
                // 사용자 정보 요청 (SDK 콜백 스레드는 SDK가 관리, 완료만 메인 보장)
                UserApi.shared.me { user, error in
                    if let error = error {
                        return completeOnMain(.failure(AuthError.signInFailed(reason: error.localizedDescription)))
                    }
                    guard let user = user else {
                        return completeOnMain(.failure(AuthError.signInFailed(reason: "No user data received")))
                    }
                    
                    let session = UserSession(
                        id: String(user.id ?? 0),
                        name: user.kakaoAccount?.profile?.nickname ?? "Unknown",
                        email: user.kakaoAccount?.email ?? "Unknown",
                        token: token.accessToken
                    )
                    completeOnMain(.success(session))
                }
            }
            
            // ✅ UI 관련 API는 반드시 메인에서 시작
            DispatchQueue.main.async {
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk(completion: loginHandler)
                } else {
                    UserApi.shared.loginWithKakaoAccount(completion: loginHandler)
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    public func signOut() -> AnyPublisher<Void, Error> {
        Future { promise in
            let completeOnMain: (Result<Void, Error>) -> Void = { result in
                if Thread.isMainThread { promise(result) }
                else { DispatchQueue.main.async { promise(result) } }
            }
            DispatchQueue.main.async {
                UserApi.shared.logout { error in
                    if let error = error {
                        completeOnMain(.failure(AuthError.signOutFailed(reason: error.localizedDescription)))
                    } else {
                        completeOnMain(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func deleteUser() -> AnyPublisher<Void, Error> {
        Future { promise in
            let completeOnMain: (Result<Void, Error>) -> Void = { result in
                if Thread.isMainThread { promise(result) }
                else { DispatchQueue.main.async { promise(result) } }
            }
            DispatchQueue.main.async {
                UserApi.shared.unlink { error in
                    if let error = error {
                        completeOnMain(.failure(AuthError.deleteUserFailed(reason: error.localizedDescription)))
                    } else {
                        completeOnMain(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
