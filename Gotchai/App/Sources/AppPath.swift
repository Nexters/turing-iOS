//
//  AppPath.swift
//  Gotchai
//
//  Created by koreamango on 8/10/25.
//

import TCA
import Main
import Setting
import Profile

@Reducer
struct AppPath {
  @ObservableState
  @CasePathable
  enum State {
      case turingTest(TuringTestFeature.State)
      case turingTestConcept(TuringTestFeature.State)
      case quiz(QuizFeature.State)
      case turingTestResult(TuringTestFeature.State)
      case setting(SettingFeature.State)
      case badgeList(BadgeListFeature.State)
      case solvedTuringTest(SolvedTuringTestFeature.State)
  }

  @CasePathable
  enum Action {
      case turingTest(TuringTestFeature.Action)
      case turingTestConcept(TuringTestFeature.Action)
      case quiz(QuizFeature.Action)
      case turingTestResult(TuringTestFeature.Action)
      case setting(SettingFeature.Action)
      case badgeList(BadgeListFeature.Action)
      case solvedTuringTest(SolvedTuringTestFeature.Action)
  }

  var body: some ReducerOf<Self> {
      Scope(state: \.turingTest, action: \.turingTest) { TuringTestFeature() }
      Scope(state: \.turingTestConcept, action: \.turingTestConcept) { TuringTestFeature() }
      Scope(state: \.quiz, action: \.quiz) { QuizFeature() }
      Scope(state: \.turingTestResult, action: \.turingTestResult) { TuringTestFeature() }
      Scope(state: \.setting, action: \.setting) { SettingFeature() }
      Scope(state: \.badgeList, action: \.badgeList) { BadgeListFeature() }
      Scope(state: \.solvedTuringTest, action: \.solvedTuringTest) { SolvedTuringTestFeature() }
  }
}
