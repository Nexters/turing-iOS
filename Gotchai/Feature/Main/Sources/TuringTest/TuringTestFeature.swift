//
//  TuringTestFeature.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import ComposableArchitecture

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
    
    public enum Action {
        case onAppearIntroView
        case tappedTestShareButton
        case moveToConceptView
        case moveToQuizView
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppearIntroView:
                // TODO: 데이터 fetch
                
                return .none
            case .tappedTestShareButton:
                return .none
            case .moveToConceptView:
                return .none
            case .moveToQuizView:
                return .none
            }
        }
    }
}
