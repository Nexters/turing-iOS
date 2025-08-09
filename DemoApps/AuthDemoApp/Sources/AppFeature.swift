//
//  AppFeature.swift
//  AuthDemoApp
//
//  Created by koreamango on 8/2/25.
//

import ComposableArchitecture
import SignIn
import Onboarding

@CasePathable
@Reducer
public enum AppDestination {
    case onboarding(OnboardingFeature)
    case signIn(SignInFeature)

    public init() {
      self = .onboarding(OnboardingFeature())
    }
}

@Reducer
public struct AppFeature {
  @ObservableState
  public struct State {
      public var rootOnboarding = OnboardingFeature.State()
      public var path = StackState<AppDestination.State>()
      public init() { }
  }

  @CasePathable
  public enum Action {
      case onboarding(OnboardingFeature.Action)
      case path(StackActionOf<AppDestination>)
      case routeToSignIn
  }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.rootOnboarding, action: \.onboarding) {
          OnboardingFeature()
        }

        Reduce { state, action in
            switch action {
                case .routeToSignIn:
                    state.path.append(.signIn(.init()))
                    print("STACK ->", state.path)

                    return .none
                case .onboarding(let childAction):
                    print("ONBOARDING ACTION ->", childAction)
                    print("STACK ->", state.path)
                    return .none

                case .path(let stackAction):
                    print("PATH ACTION ->", stackAction)
                    print("STACK ->", state.path)
                    return .none
            }
        }
        .forEach(\.path, action: \.path) {
          AppDestination()
        }
    }
}
