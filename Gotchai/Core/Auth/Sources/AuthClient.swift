//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import Combine

final class AuthClient {
  private let provider: AuthProvider

  init(provider: AuthProvider) {
    self.provider = provider
  }

  func signIn() -> AnyPublisher<UserSession, Error> {
    provider.signIn()
  }

  func signOut() -> AnyPublisher<Void, Error>  {
    provider.signOut()
  }

  func deleteUser()-> AnyPublisher<Void, Error>  {
    provider.deleteUser()
  }
}
