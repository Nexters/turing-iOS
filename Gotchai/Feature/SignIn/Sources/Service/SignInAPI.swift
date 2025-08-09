//
//  SignInAPI.swift
//  Feature/SignIn
//
//  Created by koreamango on 8/9/25.
//

import Network
import Auth
import Moya

enum SignInAPI {
    case kakao(KakaoSignInRequestDTO)
    case apple(AppleSignInRequestDTO)
}

extension SignInAPI: BaseTarget {
    var path: String {
        switch self {
        case .kakao:
            return "/api/v1/auth/login/kakao"
        case .apple:
            return "/api/v1/auth/login/apple"
        }
    }

    var method: Moya.Method {
        .post
    }

    var task: Task {
        switch self {
        case .kakao(let request):
            return .requestJSONEncodable(request)
        case .apple(let request):
            return .requestJSONEncodable(request)
        }
    }
}
