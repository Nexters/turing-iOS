//
//  AuthClient.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import ComposableArchitecture

enum LoginType {
    case apple, kakao
}

struct User {
    let id: Int
    let name: String
}

public struct AuthClient {
    var login: (LoginType) async throws -> User
}

extension AuthClient: DependencyKey {
    public static var liveValue = AuthClient { type in
        switch type {
        case .apple:
        case .kakao:
        }
    }
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
