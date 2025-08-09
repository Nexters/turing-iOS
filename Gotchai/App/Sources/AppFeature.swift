//
//  AppFeature.swift
//  Gotchai
//
//  Created by 가은 on 8/2/25.
//
import TCA
import Onboarding
import SignIn
import Main // 모듈명이 Swift의 @main 과 헷갈리면 이름 변경 고려

@Reducer
struct AppFeature {
  struct State {
    enum Root: Equatable { case onboarding, signIn, main }
    var root: Root = .onboarding

    var onboarding = OnboardingFeature.State()
    var signIn     = SignInFeature.State()
    var main       = MainFeature.State()
  }

  enum Action {
    case onboarding(OnboardingFeature.Action)
    case signIn(SignInFeature.Action)
    case main(MainFeature.Action)
    case setRoot(State.Root)
  }

  // 핵심 리듀서를 분리(타입 추론 안정화)
  private var core: some ReducerOf<Self> {
      Reduce { state, action in
           switch action {
           // 온보딩 → 로그인으로
           case .onboarding(.delegate(.navigateToSignIn)):
             state.root = .signIn
             return .none

           // 로그인 성공 → 메인으로
           case .signIn(.delegate(.didSignIn)):
             state.root = .main
             return .none

           // 필요 시 메인에서 로그아웃 이벤트 받아 루트 전환
           case .main:
             return .none

           case let .setRoot(root):
             state.root = root
             return .none

           default:
             return .none
           }
         }
      
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.onboarding, action: /Action.onboarding) { OnboardingFeature() }
    Scope(state: \.signIn,     action: /Action.signIn)     { SignInFeature() }
    Scope(state: \.main,       action: /Action.main)       { MainFeature() }
    core
  }
}
