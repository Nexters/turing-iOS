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

    public func fetchBadges() -> AnyPublisher<[Badge], Error> {
        networkClient
            .request(BadgeAPI.fetchBadges , type: BadgeListResponseDTO.self)
            .map { $0.badges.map(Badge.init(dto:)) }
            .eraseToAnyPublisher()
    }
}
