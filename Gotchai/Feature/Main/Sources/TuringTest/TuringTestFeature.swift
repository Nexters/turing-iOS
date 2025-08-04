//
//  TuringTestFeature.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import ComposableArchitecture

@Reducer
public struct TuringTestFeature {
    
    @ObservableState
    public struct State {
        var turingTest: TuringTest
        
        init(turingTest: TuringTest = TuringTest.dummy) {
            self.turingTest = turingTest
        }
    }
    
    public enum Action {
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}
