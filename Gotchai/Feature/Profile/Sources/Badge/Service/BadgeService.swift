//
//  BadgeService.swift
//  Profile
//
//  Created by koreamango on 8/15/25.
//

import Foundation
import CustomNetwork
import TCA
import Combine

public struct BadgeService {
    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func fetchBadges() -> AnyPublisher<BadgeListResponseDTO, Error> {
        networkClient
            .request(BadgeAPI.fetchBadges , type: BadgeListResponseDTO.self)
            .handleEvents(receiveOutput: { response in
                print("✅ fetch Badges 응답:", response)
            })
            .eraseToAnyPublisher()
    }
}
