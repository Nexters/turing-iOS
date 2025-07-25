//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import ComposableArchitecture

public enum SignInType {
    case apple, kakao
}

public struct User {
    let id: String
    let name: String
}

public struct SignInClient {
    var signIn: (SignInType) async throws -> User
}

extension DependencyValues {
    var signInClient: SignInClient {
        get { self[SignInClient.self] }
        set { self[SignInClient.self] = newValue }
    }
}
