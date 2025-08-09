//
//  AppView.swift
//  Gotchai
//
//  Created by 가은 on 8/2/25.
//

import TCA
import SwiftUI
import SignIn
import Auth
import Onboarding
import Main

struct AppView: View {
  let store: StoreOf<AppFeature>

  var body: some View {
    WithViewStore(store, observe: \.root) { viewStore in
      switch viewStore.state {
      case .onboarding:
        OnboardingView(
          store: store.scope(state: \.onboarding, action: AppFeature.Action.onboarding)
        )

      case .signIn:
        SignInView(
          store: store.scope(state: \.signIn, action: AppFeature.Action.signIn)
        )

      case .main:
        // 필요 시 여기서 NavigationStackStore를 둘러서
        // 메인 내부 push를 확장 가능
        MainView(
          store: store.scope(state: \.main, action: AppFeature.Action.main)
        )
      }
    }
  }
}
