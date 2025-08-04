//
//  QuizFeature.swift
//  Main
//
//  Created by 가은 on 8/3/25.
//

import ComposableArchitecture

@Reducer
struct QuizFeature {
    @ObservableState
    struct State: Equatable {
        var quiz: Quiz = Quiz.dummy
        var progress: QuizProgress = .notAnswered
        var answer: String = ""
        var isAnswerPopUpPresented: Bool = false
    }
    
    enum Action {
        case initQuiz
        case selectAnswer(Int)
        case setAnswerPopUpPresented(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectAnswer(id):
                
                // dummy
                state.answer = "음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?"
                state.progress = .correct
                
                return .send(.setAnswerPopUpPresented(true))
            case let .setAnswerPopUpPresented(isPresented):
                state.isAnswerPopUpPresented = isPresented
                return .none
            case .initQuiz:
                return .none
            }
        }
    }
}

public enum QuizProgress: Equatable {
    case notAnswered
    case correct
    case incorrect
    case timeout
}
