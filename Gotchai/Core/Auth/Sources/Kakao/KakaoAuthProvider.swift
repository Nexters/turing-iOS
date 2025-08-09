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

public final class KakaoAuthProvider: AuthProvider {
    private let appKey: String

    public init(appKey: String) {
        self.appKey = appKey
        KakaoSDK.initSDK(appKey: appKey)
    }
    public func signIn() -> AnyPublisher<UserSession, any Error> {
        Future { promise in
            // promise를 메인에서 안전하게 완료
            let completeOnMain: (Result<UserSession, Error>) -> Void = { result in
                if Thread.isMainThread {
                    promise(result)
                } else {
                    DispatchQueue.main.async { promise(result) }
                }
            }

            // 카카오 SDK 콜백
            let loginHandler: (OAuthToken?, Error?) -> Void = { token, error in
                if let error = error {
                    return completeOnMain(.failure(error))
                }
                guard let token = token else {
                    return completeOnMain(.failure(NSError(
                        domain: "KakaoAuth",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No token received"]
                    )))
                }

                // 사용자 정보 요청 (네트워크 콜이라 메인 강제 불필요하지만, 완료는 main에서)
                UserApi.shared.me { user, error in
                    if let error = error {
                        return completeOnMain(.failure(error))
                    }
                    guard let user = user else {
                        return completeOnMain(.failure(NSError(
                            domain: "KakaoAuth",
                            code: -2,
                            userInfo: [NSLocalizedDescriptionKey: "No user data received"]
                        )))
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

            // ✅ UI API는 반드시 메인 스레드에서 시작
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


    public func signOut() -> AnyPublisher<Void, any Error> {
        Future { promise in
            UserApi.shared.logout { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func deleteUser() -> AnyPublisher<Void, any Error> {
        Future { promise in
            UserApi.shared.unlink { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
