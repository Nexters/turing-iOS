//
//  AppView.swift
//  Gotchai
//
//  Created by 가은 on 8/2/25.
//

import ComposableArchitecture
import Onboarding
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            // TODO: 로딩 화면
            ProgressView()
        } destination: { store in
            switch store.case {
            case let .onboarding(store):
                OnboardingView(store: store)
            }
        }
        .task {
            store.send(.onLaunch)
        }
    }
}
