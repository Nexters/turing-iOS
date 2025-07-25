//
//  AuthProvider.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine

protocol AuthProvider {
  func signIn() -> AnyPublisher<UserSession, Error>
  func signOut() -> AnyPublisher<Void, Error>
  func deleteUser() -> AnyPublisher<Void, Error>
}
