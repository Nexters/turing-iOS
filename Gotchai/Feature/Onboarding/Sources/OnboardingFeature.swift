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
      .init(imageName: "onboarding1", title: "AI와 사람의 경계가 희미해진 시대에서\n안녕하신가요?"),
      .init(imageName: "onboarding2", title: "다양한 테마의 퀴즈에서\nAi가 작성한 대답을 선택해요"),
      .init(imageName: "onboarding3", title: "Ai의 답변을 모두 맞추고\n뱃지를 모아보아요"),
      .init(imageName: "onboarding4", title: "그럼, 사람 사이에 숨은 Ai를\n찾으러 가 볼까요?")
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
