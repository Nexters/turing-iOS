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
    let id: String
    let name: String
}

public struct AuthClient {
    var login: (LoginType) async throws -> User
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
