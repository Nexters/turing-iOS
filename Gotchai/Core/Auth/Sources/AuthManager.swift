//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine

public final class AuthManager {
    private let provider: AuthProvider
    
    public init(provider: AuthProvider) {
        self.provider = provider
    }
    
    public func signIn() -> AnyPublisher<UserSession, Error> {
        provider.signIn()
    }
    
    public func signOut() -> AnyPublisher<Void, Error>  {
        provider.signOut()
    }
    
    public func deleteUser()-> AnyPublisher<Void, Error>  {
        provider.deleteUser()
    }
}
