//
//  QuizFeature.swift
//  Main
//
//  Created by 가은 on 8/3/25.
//

import Combine
import TCA
import SwiftUI

@Reducer
public struct QuizFeature {
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        var quiz: Quiz
        var progress: QuizProgress
        var answerCardState: [AnswerCardState]
        var answer: String
        var isAnswerPopUpPresented: Bool
        
        public init(
            quiz: Quiz = Quiz.dummy,
            progress: QuizProgress = .notAnswered,
            answer: String = "",
            isAnswerPopUpPresented: Bool = false
        ) {
            self.quiz = quiz
            self.progress = progress
            self.answerCardState = Array(repeating: .idle, count: quiz.answers.count)
            self.answer = answer
            self.isAnswerPopUpPresented = isAnswerPopUpPresented
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case initQuiz
        case selectAnswer(Int, Int)
        case setAnswerPopUpPresented(Bool)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                // TODO: 타이머 관리 + 데이터 setting
                return .none
            case let .selectAnswer(index, id):
                for i in 0..<state.answerCardState.count {
                    if i == index {
                        state.answerCardState[i] = .selected
                    } else {
                        state.answerCardState[i] = .unselected
                    }
                }
                
                // dummy
                state.answer = "음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?"
                state.progress = .correct
                
                return .publisher {
                    Just(.setAnswerPopUpPresented(true))
                        .delay(for: .seconds(1), scheduler: RunLoop.main)   // 임시 1초
                        .eraseToAnyPublisher()
                }
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

enum AnswerCardState {
    case idle
    case selected
    case unselected
}
