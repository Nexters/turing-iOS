//
//  MainFeature.swift
//  Main
//
//  Created by 가은 on 7/26/25.
//

import ComposableArchitecture

@Reducer
public struct MainFeature {
    
    @ObservableState
    public struct State {
        var selectedTab: Tab = .turingTest
    }
    
    public enum Action {
        case selectedTabChanged(Tab)
        case settingButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
            case .settingButtonTapped:
                return .none
            }
        }
    }
}

public enum Tab: String, CaseIterable {
    case turingTest = "테스트"
    case achievement = "내 업적"
}
