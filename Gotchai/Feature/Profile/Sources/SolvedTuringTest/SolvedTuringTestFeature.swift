//
//  SolvedTuringTestFeature.swift
//  Profile
//
//  Created by koreamango on 8/16/25.
//

import ComposableArchitecture
import SwiftUI
import Combine

@Reducer
public struct SolvedTuringTestFeature {
    @Dependency(\.solvedTuringTestService) var solvedTuringTestService
    
    public init() { }

    @ObservableState
    public struct State {
        var solvedTuringTests: [SolvedTuringTest]
        var isLoading = false
        var error: String?
        
        public init(solvedTuringTests: [SolvedTuringTest] = SolvedTuringTest.dummyList, isLoading: Bool = false, error: String? = nil) {
            self.solvedTuringTests = solvedTuringTests
            self.isLoading = isLoading
            self.error = error
        }
    }
    
    public enum Delegate {
        case moveToMainView
    }

    public enum Action {
        case task                  // 뷰 등장/갱신 트리거
        case testsLoaded([SolvedTuringTest])
        case failed(String)
        case tappedBackButton
        case delegate(Delegate)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .task:
                state.isLoading = true
                state.error = nil
                return .publisher {
                    solvedTuringTestService.fetchSolvedTuringTests()
                        .tryMap { dto -> [SolvedTuringTest] in
                            guard dto.isSuccess else {
                                throw SolvedTuringTestError
                                    .server(status: dto.status)
                            }
                            return dto.data.list.map(SolvedTuringTest.init(dto:))
                        }
                        .map(SolvedTuringTestFeature.Action.testsLoaded)
                        .catch { Just(.failed($0.localizedDescription)) }
                        .receive(on: DispatchQueue.main)
                }

            case .testsLoaded(let items):
                state.isLoading = false
                state.solvedTuringTests = items
                return .none

            case .failed(let message):
                state.isLoading = false
                state.error = message
                return .none
                
            case .tappedBackButton:
                return .send(.delegate(.moveToMainView))
                
            case .delegate(_):
                return .none
            }
        }
    }
}
