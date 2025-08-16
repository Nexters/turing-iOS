//
//  BadgeAPI.swift
//  Profile
//
//  Created by koreamango on 8/15/25.
//

import CustomNetwork
import Moya

enum BadgeAPI {
    case fetchBadges
}

extension BadgeAPI: BaseTarget {
    var path: String {
        switch self {
        case .fetchBadges:
            return apiPrefix + "/users/me/badges"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .fetchBadges:
            return .requestPlain
        }
    }
}
