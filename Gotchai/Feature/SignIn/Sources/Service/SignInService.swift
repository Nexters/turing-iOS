//
//  SignInService.swift
//  SignIn
//
//  Created by koreamango on 8/9/25.
//

import Foundation
import Auth
import CustomNetwork
import TCA
import Combine

public struct SignInService {
    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func registerKakaoSession(_ request: KakaoSignInRequestDTO) -> AnyPublisher<AuthTokens, Error> {
        register(.kakao(request))
    }

    public func registerAppleSession(_ request: AppleSignInRequestDTO) -> AnyPublisher<AuthTokens, Error> {
        register(.apple(request))
    }

    // 공통 처리
    private func register(_ target: SignInAPI) -> AnyPublisher<AuthTokens, Error> {
        networkClient
            .request(target, type: SignInResponseDTO.self)
            .handleEvents(receiveOutput: { response in
                print("✅ 로그인 응답:", response)
            })
            .map { dto in
                AuthTokens(
                    accessToken: dto.accessToken,
                    refreshToken: dto.refreshToken
                )
            }
            .eraseToAnyPublisher()
    }
}
