//
//  AppFeature.swift
//  Gotchai
//
//  Created by 가은 on 8/2/25.
//

import ComposableArchitecture
import Onboarding

@Reducer
public struct AppFeature {
    @Reducer
    public enum Path {
        case onboarding(OnboardingFeature)
    }
    
    @ObservableState
    public struct State {
        var path = StackState<Path.State>()
    }

    public enum Action {
        case path(StackActionOf<Path>)
        case onLaunch
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onLaunch:
                state.path.append(.onboarding(OnboardingFeature.State()))
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
