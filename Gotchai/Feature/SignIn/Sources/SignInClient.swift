//
//  AuthClient.swift
//  Auth
//
//  Created by koreamango on 7/25/25.
//

import TCA
import Auth

public struct SignInClient {
  public var signInWithKakao: @Sendable (
    KakaoAuthProvider
  ) async throws -> UserSession
  public var signInWithApple: @Sendable (
    AppleAuthProvider
  ) async throws -> UserSession
}

extension DependencyValues {
  var signInClient: SignInClient {
    get { self[SignInClient.self] }
    set { self[SignInClient.self] = newValue }
  }
}
