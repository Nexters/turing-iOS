//
//  SolvedTuringTestAPI.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import CustomNetwork
import Moya

enum SolvedTuringTestAPI {
    case fetchSolvedTuringTests
}

extension SolvedTuringTestAPI: BaseTarget {
    var path: String {
        switch self {
        case .fetchSolvedTuringTests:
            return apiPrefix + "/user/me/exams/solved"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .fetchSolvedTuringTests:
            return .requestPlain
        }
    }
}
