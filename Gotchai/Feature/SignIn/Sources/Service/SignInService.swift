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

    public func registerKakaoSession(_ request: KakaoSignInRequestDTO) -> AnyPublisher<Void, Error> {
        let target = SignInAPI.kakao(request)
        
        return networkClient
            .request(target, type: SignInResponseDTO.self)
            .handleEvents(receiveOutput: { response in
               print("✅ 로그인 응답:", response)
            })
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    public func registerAppleSession(_ request: AppleSignInRequestDTO) -> AnyPublisher<Void, Error> {
        let target = SignInAPI.apple(request)

        return networkClient
            .request(target, type: SignInResponseDTO.self)
            .handleEvents(receiveOutput: { response in
               print("✅ 로그인 응답:", response)
            })
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
