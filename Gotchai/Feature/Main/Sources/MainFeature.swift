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
        var turingTestItems: [TuringTestCard] = [
            .init(id: 1, imageURL: "", title: "Ai와 크리스마스 파티", subtitle: "산타는 누구야?"),
            .init(id: 2, imageURL: "", title: "소개팅 톡 감별 테스트", subtitle: "어떤 대답이 진심일까?"),
            .init(id: 3, imageURL: "", title: "전학생과의 첫 인사", subtitle: "누가 진짜 전학생이야?")
        ]
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
