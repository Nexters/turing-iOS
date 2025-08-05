//
//  AuthFeature.swift
//  Auth
//
//  Created by 가은 on 7/20/25.
//

import ComposableArchitecture
import Auth
import Navigation

@Reducer
public struct SignInFeature {
    @Dependency(\.kakaoAuthProvider) var kakaoAuthProvider
    @Dependency(\.appleAuthProvider) var appleAuthProvider
    @Dependency(\.appRouter) var appRouter
    @Dependency(\.signInClient) var signInClient

  @ObservableState
  public struct State: Equatable {
    public init() { }
    var isLoading: Bool = false
    var user: UserSession?
  }

  public enum Action {
    case tappedKakaoLogin
    case tappedAppleLogin
    case signInResponse(Result<UserSession, Error>)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tappedKakaoLogin:
        state.isLoading = true
        
        return .run { send in
          let session = try await signInClient.signInWithKakao(kakaoAuthProvider)
          await send(.signInResponse(.success(session)))
        } catch: { error, send in
          await send(.signInResponse(.failure(error)))
        }
        
      case .tappedAppleLogin:
        state.isLoading = true
        return .run { send in
          let session = try await signInClient.signInWithApple(appleAuthProvider)
          await send(.signInResponse(.success(session)))
        } catch: { error, send in
          await send(.signInResponse(.failure(error)))
        }
        
      case let .signInResponse(.success(session)):
        state.isLoading = false
        print("로그인 성공: \(session)")
        return .none
        
      case let .signInResponse(.failure(error)):
        state.isLoading = false
        print(error)
        return .none
      }
    }
  }
}


