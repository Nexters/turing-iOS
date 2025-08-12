//
//  TuringTestFeature.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import TCA

@Reducer
public struct TuringTestFeature {
    
    public init() { }
    
    @ObservableState
    public struct State {
        var turingTest: TuringTest
        
        public init(turingTest: TuringTest = TuringTest.dummy) {
            self.turingTest = turingTest
        }
    }
    
    public enum Delegate {
        case moveToConceptView
        case moveToQuizView
    }
    
    public enum Action {
        case onAppearIntroView
        case tappedTestShareButton
        case tappedStartButton
        case tappedNextButton
        case delegate(Delegate)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppearIntroView:
                // TODO: 데이터 fetch
                
                return .none
            case .tappedTestShareButton:
                return .none
            case .tappedStartButton:
                return .send(.delegate(.moveToConceptView))
            case .tappedNextButton:
                return .send(.delegate(.moveToQuizView))
            case .delegate:
                return .none
            }
        }
    }
}
