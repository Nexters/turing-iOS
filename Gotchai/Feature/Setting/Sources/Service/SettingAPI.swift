//
//  SettingAPI.swift
//  Setting
//
//  Created by koreamango on 8/15/25.
//

import CustomNetwork
import Auth
import Moya

enum SettingAPI {
    case signOut
    case delete
}

extension SettingAPI: BaseTarget {
    var path: String {
        switch self {
        case .signOut:
            return apiPrefix + "/auth/logout"
        case .delete:
            return apiPrefix + ""
        }
    }

    var method: Moya.Method {
        .post
    }

    var task: Task {
        switch self {
        case .signOut:
            return .requestPlain
        case .delete:
            return .requestPlain
        }
    }
}
