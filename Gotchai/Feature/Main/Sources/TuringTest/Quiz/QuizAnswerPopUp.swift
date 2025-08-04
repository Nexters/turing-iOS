//
//  QuizAnswerPopUp.swift
//  Main
//
//  Created by 가은 on 8/3/25.
//

import DesignSystem
import SwiftUI

struct QuizAnswerPopUp: ViewModifier {
    @Binding var isPresented: Bool
    let state: QuizProgress
    let answerText: String
    let action: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isPresented ? 4 : 0)
            
            PopUpView()
                .opacity(isPresented ? 1 : 0)
                .allowsHitTesting(isPresented)
        }
    }
    
    @ViewBuilder
    private func PopUpView() -> some View {
        VStack {
            Image(image, bundle: .module)
                .frame(height: 120)
            Text(title)
                .fontStyle(.subtitle_1)
                .foregroundStyle(Color(.gray_50))
                .padding(.top, 36)
            VStack(spacing: 8) {
                Text("정답 공개")
                    .fontStyle(.body_4)
                    .foregroundStyle(Color(.gray_200))
                Rectangle()
                    .fill(Color(.gray_600))
                    .frame(height: 0.6)
                Text("음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?")
                    .fontStyle(.body_1)
                    .foregroundStyle(Color(.gray_100))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.gray_800))
            )
            .padding(.top, 16)
            
            CTAButton(text: state == .timeout ? "다음 문제로 넘어가기" : "다음") {
                isPresented = false
                action()
            }
            .padding(.top, 32)

        }
        .padding(EdgeInsets(top: 40, leading: 24, bottom: 24, trailing: 24))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.gray_900))
        )
        .padding(.horizontal, 37)
    }
    
    private var image: String {
        switch state {
        case .correct:  
            return "quiz_correct"
        case .incorrect: 
            return "quiz_incorrect"
        case .timeout:  
            return "quiz_timeout"
        default: 
            return ""
        }
    }
    
    private var title: String {
        switch state {
        case .correct:
            return "AI를 찾아냈어요!"
        case .incorrect:
            return "사람이 작성한 대답이에요"
        case .timeout:
            return "시간이 초과됐어요!"
        default: 
            return ""
        }
    }
}

extension View {
    func answerPopUp(isPresented: Binding<Bool>, quizProgress: QuizProgress, answerText: String, action: @escaping () -> Void) -> some View {
        self.modifier(QuizAnswerPopUp(isPresented: isPresented, state: quizProgress, answerText: answerText, action: action))
    }
}
