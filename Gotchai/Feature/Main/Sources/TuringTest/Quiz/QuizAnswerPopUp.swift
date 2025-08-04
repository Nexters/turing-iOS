//
//  QuizAnswerPopUp.swift
//  Main
//
//  Created by 가은 on 8/3/25.
//

import DesignSystem
import SwiftUI

struct QuizAnswerPopUp: View {
    
    var body: some View {
        VStack {
            Image("")
                .frame(height: 120)
            Text("AI를 찾아냈어요!")
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
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.gray_800))
            )
            .padding(.top, 16)
            
            CTAButton(text: "다음") {
                
            }
            .padding(.top, 32)

        }
        .padding(EdgeInsets(top: 40, leading: 24, bottom: 24, trailing: 24))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.gray_900))
        )
        .padding(.horizontal, 37)
        .frame(maxHeight: .infinity)
        .background(
            Color.clear.blur(radius: 4)
        )
    }
}

#Preview {
    QuizAnswerPopUp()
}
