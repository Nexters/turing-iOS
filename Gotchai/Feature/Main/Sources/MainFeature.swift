//
//  MainFeature.swift
//  Main
//
//  Created by 가은 on 7/26/25.
//

import ComposableArchitecture

@Reducer
public struct MainFeature {
    
    public init() { }
    
    @ObservableState
    public struct State {
        var selectedTab: Tab = .turingTest
        var turingTestItems: [TuringTestCard]
        
        public init(selectedTab: Tab, turingTestItems: [TuringTestCard] = TuringTestCard.dummyList) {
            self.selectedTab = selectedTab
            self.turingTestItems = turingTestItems
        }
    }
    
    public enum Action {
        case selectedTabChanged(Tab)
        case testCardTapped(Int)
        case settingButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
            case let .testCardTapped(id):
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
