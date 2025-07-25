//
//  KakaoAuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine
import KakaoSDKUser
import KakaoSDKAuth
import Foundation

final class KakaoAuthProvider: AuthProvider {
    func signIn() -> AnyPublisher<UserSession, any Error> {
        Future { promise in
            // 로그인
            let loginHandler: ((OAuthToken?, Error?) -> Void) = { token, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let token = token else {
                    promise(.failure(NSError(domain: "KakaoAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No token received"])))
                    return
                }

                // 사용자 정보 요청
                UserApi.shared.me { user, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }

                    guard let user = user else {
                        promise(.failure(NSError(domain: "KakaoAuth", code: -2, userInfo: [NSLocalizedDescriptionKey: "No user data received"])))
                        return
                    }

                    let session = UserSession(
                        id: String(user.id ?? 0),
                        name: user.kakaoAccount?.profile?.nickname ?? "Unknown",
                        token: token.accessToken
                    )

                    promise(.success(session))
                }
            }

            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk(completion: loginHandler)
            } else {
                UserApi.shared.loginWithKakaoAccount(completion: loginHandler)
            }
        }
        .eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Void, any Error> {
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

    func deleteUser() -> AnyPublisher<Void, any Error> {
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
