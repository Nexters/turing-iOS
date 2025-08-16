//
//  NetworkClient.swift
//  Network
//
//  Created by koreamango on 7/20/25.
//

import Foundation
import Moya
import Combine

public protocol NetworkClient {
    func request<T: Decodable>(_ target: TargetType, type: T.Type) -> AnyPublisher<T, Error>
    func request(_ target: TargetType) -> AnyPublisher<Void, Error>   // ← 추가
}
