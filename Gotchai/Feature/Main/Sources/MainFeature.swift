//
//  MainFeature.swift
//  Main
//
//  Created by 가은 on 7/26/25.
//

import TCA

@Reducer
public struct MainFeature {
    
    public init() { }
    
    @ObservableState
    public struct State {
        var selectedTab: Tab
        var turingTestItems: [TuringTestCard]
        
        public init(selectedTab: Tab = .turingTest, turingTestItems: [TuringTestCard] = TuringTestCard.dummyList) {
            self.selectedTab = selectedTab
            self.turingTestItems = turingTestItems
        }
    }
    
    public enum Action {
        case selectedTabChanged(Tab)
        case tappedTestCard(Int)
        case tappedSettingButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
            case let .tappedTestCard(id):
                return .none
            case .tappedSettingButton:
                return .none
            }
        }
    }
}

public enum Tab: String, CaseIterable {
    case turingTest = "테스트"
    case achievement = "내 업적"
}
