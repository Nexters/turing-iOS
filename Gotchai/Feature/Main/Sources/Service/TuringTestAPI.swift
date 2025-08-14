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
    case getQuiz(Int)
    case gradeQuiz(Int, GradeQuizRequestDTO)
    case submitTest(Int)
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
        case let .getQuiz(quizID):
            return apiPrefix + "/quizzes/\(quizID)"
        case let .gradeQuiz(quizID, _):
            return apiPrefix + "/quizzes/\(quizID)/grade"
        case let .submitTest(testID):
            return apiPrefix + "/exams/\(testID)/submit"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTestList: return .get
        case .getTestDetail: return .get
        case .postTestStart: return .post
        case .getQuiz: return .get
        case .gradeQuiz: return .post
        case .submitTest: return .post
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
        case .getQuiz:
        case let .gradeQuiz(_, request):
            return .requestJSONEncodable(request)
        default:
        }
    }

}
