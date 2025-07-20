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

  public func request<T>(_ target: any Moya.TargetType, type: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
    provider
      .requestPublisher(MultiTarget(target))
      .tryMap { response in
        guard (200 ..< 300).contains(response.statusCode) else {
          throw NetworkError.statusCode(response.statusCode)
        }
        return try JSONDecoder().decode(T.self, from: response.data)
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
