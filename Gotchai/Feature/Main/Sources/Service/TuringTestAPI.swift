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
}

extension TuringTestAPI: BaseTarget {
    var path: String {
        switch self {
        case .getTestList:
            return apiPrefix + "/exams"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTestList: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTestList:
            return .requestPlain
        }
    }

}
