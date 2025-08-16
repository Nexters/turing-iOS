//
//  BadgeService+Dependency.swift
//  Profile
//
//  Created by koreamango on 8/15/25.
//

import TCA

extension BadgeService: DependencyKey {
    public static let liveValue: BadgeService = {
        BadgeService(networkClient: DependencyValues.live.networkClient)
    }()
}

public extension DependencyValues {
    var badgeService: BadgeService {
        get { self[BadgeService.self] }
        set { self[BadgeService.self] = newValue }
    }
}
