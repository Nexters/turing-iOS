//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import ComposableArchitecture

public enum LoginType {
    case apple, kakao
}

public struct User {
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
