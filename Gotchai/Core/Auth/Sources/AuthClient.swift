//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine
import TCA

public struct AuthClient: Sendable {
    public var signIn:@Sendable (_ provider: AuthProvider) -> AnyPublisher<UserSession, Error>
    public var signOut:@Sendable () -> AnyPublisher<Void, Error>
    public var deleteUser:@Sendable () -> AnyPublisher<Void, Error>
    
    public init(
        signIn: @Sendable @escaping (
            _ provider: AuthProvider
        ) -> AnyPublisher<UserSession, Error>,
        signOut: @Sendable @escaping () -> AnyPublisher<Void, Error>,
        deleteUser: @Sendable @escaping () -> AnyPublisher<Void, Error>
    ) {
        self.signIn = signIn
        self.signOut = signOut
        self.deleteUser = deleteUser
    }
}
