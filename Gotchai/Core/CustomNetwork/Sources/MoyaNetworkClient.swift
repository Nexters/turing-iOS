//
//  MoyaNetworkClient.swift
//  Network
//
//  Created by koreamango on 7/20/25.
//


import Foundation
import Moya
import Combine
import CombineMoya

public final class MoyaAPIClient: NetworkClient {
    private let provider: MoyaProvider<MultiTarget>

    public init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    public func request<T: Decodable>(
        _ target: any Moya.TargetType,
        type: T.Type
    ) -> AnyPublisher<T, any Error> {
        provider
            .requestPublisher(MultiTarget(target))
            .handleEvents(receiveOutput: { response in
              #if DEBUG
              print("🔵 RAW:", String(data: response.data, encoding: .utf8) ?? "nil")
              #endif
            })
            .tryMap { response in
                guard (200 ..< 300).contains(response.statusCode) else {
                    if let errorResponse = try? JSONDecoder().decode(APIResponse<APIError>.self, from: response.data) {
                        throw NetworkError.api(errorResponse.data)
                    }
                    throw NetworkError.statusCode(response.statusCode)
                }

                let decoded = try JSONDecoder().decode(APIResponse<T>.self, from: response.data)

                guard decoded.isSuccess else {
                    if let errorResponse = try? JSONDecoder().decode(APIResponse<APIError>.self, from: response.data) {
                        throw NetworkError.api(errorResponse.data)
                    }
                    throw NetworkError.statusCode(response.statusCode)
                }

                return decoded.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
