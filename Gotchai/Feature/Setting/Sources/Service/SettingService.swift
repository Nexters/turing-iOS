//
//  SettingService.swift
//  Setting
//
//  Created by koreamango on 8/15/25.
//

import Foundation
import Auth
import CustomNetwork
import TCA
import Combine

public struct SettingService {
    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func signOut(_ target: SettingAPI) -> AnyPublisher<Void, Error> {
        networkClient
            .request(target) // Void 오버로드
    }
}
