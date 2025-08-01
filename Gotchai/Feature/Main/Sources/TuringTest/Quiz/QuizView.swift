//
//  QuizView.swift
//  Main
//
//  Created by 가은 on 8/2/25.
//

import DesignSystem
import SwiftUI

struct QuizView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            timerBar(seconds: 2)
                .padding(.bottom, 28)
            
            Text("1/7")
                .font(.body_5)
                .foregroundStyle(DesignSystemAsset.primary400.swiftUIColor)
                .padding(.vertical, 3)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(DesignSystemAsset.primary400.swiftUIColor.opacity(0.1))
                )
            
            Text("크리스마스 트리 꾸미기  중...\n“트리에 뭔가 허전한데, 뭘 더 달까?”")
                .font(.subtitle_2)
                .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
                .padding(.top, 16)
            
            VStack(spacing: 16) {
                answerCard(idx: 0, text: "별이 없네.\n트리는 역시 별을 달아야 완성이지!")
                answerCard(idx: 1, text: "음~ 반짝이랑 리본 살짝 감으면 확 살아날 것 같은데?")
            }
            .padding(.top, 76)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(DesignSystemAsset.gray950.swiftUIColor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image("icon_xmark", bundle: .module)
                    .padding(12)
            }
        }
    }
    
    @ViewBuilder
    private func timerBar(seconds: Int) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(DesignSystemAsset.grayWhite.swiftUIColor.opacity(0.2))
                .frame(maxWidth: .infinity)
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 3)
                    .fill(DesignSystemAsset.primary400.swiftUIColor)
                    .frame(width: geometry.size.width * CGFloat(seconds/10))
            }
        }
        .frame(height: 5)
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private func answerCard(idx: Int, text: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(idx == 0 ? "A" : "B")
                .font(.body_3)
                .foregroundStyle(DesignSystemAsset.grayBlack.swiftUIColor)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DesignSystemAsset.primary400.swiftUIColor)
                )
            Text(text)
                .font(.body_4)
                .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(DesignSystemAsset.grayWhite.swiftUIColor.opacity(0.15))
        )
    }
}

#Preview {
    QuizView()
}
