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
    
    enum CancelID {
        case getTuringTestItem
        case postTuringTestStart
    }
    
    public init() { }
    
    @ObservableState
    public struct State {
        var turingTestID: Int
        var turingTest: TuringTest
        var quizIds: [Int]
        
        public init(turingTestID: Int = -1, turingTest: TuringTest = TuringTest.dummy, quizIds: [Int] = []) {
            self.turingTestID = turingTestID
            self.turingTest = turingTest
            self.quizIds = quizIds
        }
    }
    
    public enum Delegate {
        case moveToConceptView(Int, TuringTest)
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
        case postTuringTestStartResponse(Result<[Int], Error>)
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
                return .send(.delegate(.moveToConceptView(state.turingTestID, state.turingTest)))
            case .tappedNextButton:
                return .publisher {
                    turingTestService.startTuringTest(.postTestStart(state.turingTestID))
                        .map { .postTuringTestStartResponse(.success($0)) }
                        .catch { Just(.postTuringTestStartResponse(.failure($0))) }
                        .receive(on: RunLoop.main)
                }
                .cancellable(id: CancelID.postTuringTestStart)
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
            case let .postTuringTestStartResponse(result):
                switch result {
                case let .success(quizIds):
                    state.quizIds = quizIds
                    return .send(.delegate(.moveToQuizView))
                case let .failure(error):
                    print("테스트 시작 실패:", error)
                    return .none
                }
            }
        }
    }
}
