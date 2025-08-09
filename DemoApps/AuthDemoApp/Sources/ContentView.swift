//
//  ContentView.swift
//  AuthDemoAppManifests
//
//  Created by 가은 on 7/25/25.
//


import ComposableArchitecture
import SwiftUI
import SignIn
import Auth
import Onboarding

struct ContentView: View {
    let store: StoreOf<AppFeature>

    public init(store: StoreOf<AppFeature>) { self.store = store }

    public var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: AppFeature.Action.path)) {
            OnboardingView(
              store: store.scope(
                state: \.rootOnboarding,
                action: \.onboarding
              )
            )
        } destination: { state in
            switch state {
            case .onboarding:
                CaseLet(/AppDestination.State.onboarding,
                         action: AppDestination.Action.onboarding,
                         then: OnboardingView.init(store:))
            case .signIn:
                CaseLet(/AppDestination.State.signIn,
                         action: AppDestination.Action.signIn,
                         then: SignInView.init(store:))
            }
        }
    }
}
