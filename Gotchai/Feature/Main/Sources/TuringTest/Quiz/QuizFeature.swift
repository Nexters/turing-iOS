//
//  QuizFeature.swift
//  Main
//
//  Created by 가은 on 8/3/25.
//

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
struct QuizFeature {
    init() { }
    
    @ObservableState
    struct State: Equatable {
        // Timer
        var secondsElapsed: Int = 0
        let totalSeconds: Int = 10
        var isRunningTimer = false
        
        // Quiz
        var quiz: Quiz
        var progress: QuizProgress
        var answerCardState: [AnswerCardState]
        var isSelectedAnswer: Bool = false
        var answer: String
        var isAnswerPopUpPresented: Bool
        
        init(
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
    
    enum Action: Equatable {
        // Life Cycle
        case onAppear
        
        // Timer
        case startTimer
        case stopTimer
        case tick
        
        // Quiz
        case initQuiz
        case selectAnswer(Int, Int)
        case setAnswerPopUpPresented(Bool)
    }
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                
                // TODO: 데이터 setting
                return .send(.startTimer)
            case .startTimer:
                state.secondsElapsed = 0
                state.isRunningTimer = true
                
                return .run { send in
                    let timerSequence = Timer.publish(every: 1.0, on: .main, in: .common)
                        .autoconnect()
                        .values
                    
                    for await _ in timerSequence {
                        await send(.tick)
                    }
                }
                .cancellable(id: CancelID.timer)
            case .stopTimer:
                state.isRunningTimer = false
                return .cancel(id: CancelID.timer)
            case .tick:
                if state.secondsElapsed < state.totalSeconds {
                    state.secondsElapsed += 1
                    return .none
                } else {
                    state.isRunningTimer = false
                    return .concatenate(
                        .cancel(id: CancelID.timer),
                        .send(.selectAnswer(-1, 0)) // 임시 값, 10초가 되었을 때 이후 작업을 하기 위함
                    )
                }
            case let .selectAnswer(index, id):
                if state.isSelectedAnswer { return .none }
                
                state.isRunningTimer = false
                state.isSelectedAnswer = true
                
                for i in 0..<state.answerCardState.count {
                    if i == index {
                        state.answerCardState[i] = .selected
                    } else {
                        state.answerCardState[i] = .unselected
                    }
                }
                
                // dummy
                state.answer = "음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?"
                state.progress = index == -1 ? .timeout : .correct
                
                return .concatenate(
                    .cancel(id: CancelID.timer),
                    .publisher {
                        Just(.setAnswerPopUpPresented(true))
                            .delay(for: .seconds(0.3), scheduler: RunLoop.main)   
                            .eraseToAnyPublisher()
                    }
                )
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
