//
//  OnboardingFeature.swift
//  Onboarding
//
//  Created by koreamango on 7/28/25.
//

import ComposableArchitecture

@Reducer
public struct OnboardingFeature {
  @ObservableState
  public struct State: Equatable, Sendable {
    public init () {}
    public var currentPage: Int = 0
    public var pages: [OnboardingPage] = [
      .init(imageName: "onboarding1", title: "AI와 사람의 경계가 희미해진 시대에서\n안녕하세요?"),
      .init(imageName: "onboarding2", title: "아무리 사람처럼 말한다고 해도\nAI가 사람보다 마음을\n더 잘 전달할 수는 없겠죠."),
      .init(imageName: "onboarding3", title: "그럼, 사람 사이에 숨은 AI를\n찾으러 가 볼까요?")
    ]
  }

  public enum Action: Sendable {
    case pageChanged(Int)
    case nextButtonTapped
    case start
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .pageChanged(index):
        state.currentPage = index
        return .none

      case .nextButtonTapped:
        if state.currentPage < state.pages.count - 1 {
          state.currentPage += 1
          return .none
        } else {
          return .send(.start)
        }

      case .start:
        return .none
      }
    }
  }
}
