//
//  AuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine

public protocol AuthProvider {
  func signIn() -> AnyPublisher<UserSession, any Error>
  func signOut() -> AnyPublisher<Void, any Error>
  func deleteUser() -> AnyPublisher<Void, any Error>
}
