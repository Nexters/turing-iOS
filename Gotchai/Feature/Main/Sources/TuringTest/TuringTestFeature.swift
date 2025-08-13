//
//  TuringTestFeature.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import Foundation
import Combine
import TCA

@Reducer
public struct TuringTestFeature {
    @Dependency(\.turingTestService) var turingTestService
    
    enum CancelID { case getTuringTestItem }
    
    public init() { }
    
    @ObservableState
    public struct State {
        var turingTestID: Int
        var turingTest: TuringTest
        
        public init(turingTestID: Int = -1, turingTest: TuringTest = TuringTest.dummy) {
            self.turingTestID = turingTestID
            self.turingTest = turingTest
        }
    }
    
    public enum Delegate {
        case moveToConceptView
        case moveToQuizView
        case moveToMainView
    }
    
    public enum Action {
        // life cycle
        case onAppearIntroView
        
        // view
        case tappedTestShareButton
        case tappedStartButton
        case tappedNextButton
        case tappedBackButton
        case delegate(Delegate)
        
        // data
        case getTuringTestResponse(Result<TuringTest, Error>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppearIntroView:
                // 데이터 fetch
                return .publisher {
                    turingTestService.getTuringTest(.getTestDetail(state.turingTestID))
                        .map { TuringTestFeature.Action.getTuringTestResponse(.success($0)) }
                        .catch{ Just(.getTuringTestResponse(.failure($0))) }
                        .receive(on: RunLoop.main)
                }
                .cancellable(id: CancelID.getTuringTestItem)
            case .tappedTestShareButton:
                return .none
            case .tappedStartButton:
                return .send(.delegate(.moveToConceptView))
            case .tappedNextButton:
                return .send(.delegate(.moveToQuizView))
            case .tappedBackButton:
                return .send(.delegate(.moveToMainView))
            case .delegate:
                return .none
            case let .getTuringTestResponse(result):
                switch result {
                case let .success(turingTest):
                    state.turingTest = turingTest
                    return .none
                case let .failure(error):
                    print("테스트 데이터 fetch 실패:", error)
                    return .none
                }
                
            }
        }
    }
}
