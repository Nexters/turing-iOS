//
//  AuthClient+Live.swift
//  Auth
//
//  Created by 가은 on 7/23/25.
//

import ComposableArchitecture
import Auth
import Combine

extension SignInClient: DependencyKey {
  public static let liveValue: SignInClient = {

    return SignInClient(
      signInWithKakao: { provider in
        let authManager = AuthManager(provider: provider)
        return try await authManager.signIn().asyncValue()
      },
      signInWithApple: { provider in
        let authManager = AuthManager(provider: provider)
        return try await authManager.signIn().asyncValue()
      }
    )
  }()
}

extension Publisher {
  func asyncValue() async throws -> Output {
    try await withCheckedThrowingContinuation { continuation in
      var cancellable: AnyCancellable?

      cancellable = self
        .first() // 값 1개만
        .sink(
          receiveCompletion: { completion in
            if case let .failure(error) = completion {
              continuation.resume(throwing: error)
            }
            cancellable = nil
          },
          receiveValue: { value in
            continuation.resume(returning: value)
            cancellable = nil
          }
        )
    }
  }
}
