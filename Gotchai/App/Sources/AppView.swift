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
                    store: store.scope(state: \.onboarding, action: \.onboarding)
                )

            case .signIn:
                SignInView(
                    store: store.scope(state: \.signIn, action: \.signIn)
                )

            case .main:
                // 필요 시 여기서 NavigationStackStore를 둘러서
                // 메인 내부 push를 확장 가능
                NavigationStackStore(
                    // ✅ path에 바인딩
                    store.scope(state: \.path, action: \.path)
                ) {
                    // ✅ root(첫 화면)
                    MainView(
                        store: store.scope(state: \.main, action: \.main)
                    )
                } destination: { state in
                    // ✅ 목적지 매핑
                    switch state {
                    case .turingTest:
                        CaseLet(
                            \AppPath.State.turingTest,
                            action: AppPath.Action.turingTest,
                            then: TuringTestIntroView.init(store:)
                        )
                    }
                }
            }
        }
    }
}
