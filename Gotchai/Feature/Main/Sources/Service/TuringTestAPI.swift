//
//  TuringTestAPI.swift
//  Main
//
//  Created by 가은 on 8/13/25.
//

import CustomNetwork
import Moya

enum TuringTestAPI {
    case getTestList
    case getTestDetail(Int)
    case postTestStart(Int)
}

extension TuringTestAPI: BaseTarget {
    var path: String {
        switch self {
        case .getTestList:
            return apiPrefix + "/exams"
        case let .getTestDetail(id):
            return apiPrefix + "/exams/\(id)"
        case let .postTestStart(testID):
            return apiPrefix + "/exams/\(testID)/start"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTestList: return .get
        case .getTestDetail: return .get
        case .postTestStart: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTestList:
            return .requestPlain
        case .getTestDetail:
            return .requestPlain
        case .postTestStart:
            return .requestPlain
        }
    }

}
