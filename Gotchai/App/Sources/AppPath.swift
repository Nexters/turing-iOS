//
//  AppPath.swift
//  Gotchai
//
//  Created by koreamango on 8/10/25.
//

import TCA
import Main

@Reducer
struct AppPath {
  @ObservableState
  @CasePathable
  enum State {
      case turingTest(TuringTestFeature.State)
      case turingTestConcept(TuringTestFeature.State)
  }

  @CasePathable
  enum Action {
      case turingTest(TuringTestFeature.Action)
      case turingTestConcept(TuringTestFeature.Action)
  }

  var body: some ReducerOf<Self> {
      Scope(state: \.turingTest, action: \.turingTest) { TuringTestFeature() }
      Scope(state: \.turingTestConcept, action: \.turingTestConcept) { TuringTestFeature() }
  }
}
