//
//  QuizView.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

struct QuizView: View {
    let store: StoreOf<QuizFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                timerBar(seconds: 2)
                    .padding(.top, 4)
                    .padding(.bottom, 28)
                
                Text("1/7")
                    .fontStyle(.body_5)
                    .foregroundStyle(Color(.primary_400))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.primary_400).opacity(0.1))
                    )
                
                Text(store.quiz.contents)
                    .fontStyle(.subtitle_2)
                    .foregroundStyle(Color(.gray_white))
                    .padding(.top, 16)
                
                VStack(spacing: 16) {
                    ForEach(Array(store.quiz.answers.enumerated()), id: \.offset) { index, item in
                        Button {
                            // TODO: index를 id로 변경
                            store.send(.selectAnswer(index))
                        } label: {
                            AnswerCard(idx: index, text: item)
                        }
                    }
                }
                .padding(.top, 76)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 24)
            .background(Color(.gray_950))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image("icon_xmark", bundle: .module)
                        .padding(12)
                }
            }
            .answerPopUp(
                isPresented: viewStore.binding(
                    get: \.isAnswerPopUpPresented,
                    send: QuizFeature.Action.setAnswerPopUpPresented),
                quizProgress: viewStore.progress,
                answerText: viewStore.answer,
                action: {
                    viewStore.send(.initQuiz)
                }
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    @ViewBuilder
    private func timerBar(seconds: Int) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.gray_white).opacity(0.2))
                .frame(maxWidth: .infinity)
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.primary_400))
                    .frame(width: geometry.size.width * CGFloat(seconds/10))
            }
        }
        .frame(height: 5)
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private func AnswerCard(idx: Int, text: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(idx == 0 ? "A" : "B")
                .fontStyle(.body_3)
                .foregroundStyle(Color(.gray_black))
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.primary_400))
                )
            Text(text)
                .fontStyle(.body_4)
                .foregroundStyle(Color(.gray_white))
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.gray_white).opacity(0.15))
        )
    }
}

#Preview {
    QuizView(store: Store(initialState: QuizFeature.State(), reducer: {
        QuizFeature()
    }))
}
