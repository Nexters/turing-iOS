//
//  MainFeature.swift
//  Main
//
//  Created by 가은 on 7/26/25.
//

import Foundation
import Combine
import TCA

@Reducer
public struct MainFeature {
    @Dependency(\.turingTestService) var turingTestService
    
    enum CancelID { case getTuringTestList }
    
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

    public enum Delegate {
        case openTuringTest(TuringTestCard)
        case moveToSetting
    }

    public enum Action {
        // life cycle
        case onAppear
        
        // view
        case selectedTabChanged(Tab)
        case tappedTestCard(Int)
        case tappedSettingButton
        case delegate(Delegate)
        
        // data
        case turingTestListResponse(Result<[TuringTestCard], Error>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .publisher {
                    turingTestService.getTestList(.getTestList)
                        .map { MainFeature.Action.turingTestListResponse(.success($0)) }
                        .catch{ Just(.turingTestListResponse(.failure($0))) }
                        .receive(on: RunLoop.main)
                }
                .cancellable(id: CancelID.getTuringTestList)
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
            case let .tappedTestCard(id):
                guard let item = state.turingTestItems.first(where: { $0.id == id }) else { return .none }
                return .send(.delegate(.openTuringTest(item)))
            case .tappedSettingButton:
                return .send(.delegate(.moveToSetting))
            case .delegate: return .none
            case let .turingTestListResponse(.success(items)):
                // 리스트 데이터 저장
                state.turingTestItems = items
                return .none
            case let .turingTestListResponse(.failure(error)):
                print("테스트 리스트 fetch 실패:", error)
                return .none
            }
        }
    }
}

public enum Tab: String, CaseIterable {
    case turingTest = "테스트"
    case achievement = "내 업적"
}
