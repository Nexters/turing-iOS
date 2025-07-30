//
//  TuringTestIntroView.swift
//  TuringTest
//
//  Created by 가은 on 7/30/25.
//

import DesignSystem
import SwiftUI

struct TuringTestIntroView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image("")
                .resizable()
                .frame(width: 40, height: 40)
                .background(.yellow)    // 임시
            Text("Ai와 크리스마스 파티")
                .font(.title_2)
                .foregroundStyle(DesignSystemAsset.primary400.swiftUIColor)
                .padding(.top, 12)
            Text("산타는 누구야?")
                .font(.title_4)
                .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
                .padding(.top, 2)
            Text("Ai가 한 말은 무엇일까요?")
                .font(.body_3)
                .foregroundStyle(DesignSystemAsset.gray300.swiftUIColor)
                .padding(.top, 24)
            Image("")
                .frame(width: 305, height: 305)
                .background(
                    Circle().fill(DesignSystemAsset.gray800.swiftUIColor)
                )
                .padding(.top, 44)
            
            VStack(spacing: 12) {
                startButton()
                shareButton()
            }
            .padding(.top, 52)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystemAsset.gray950.swiftUIColor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("icon_arrow_back", bundle: .module)
            }
        }
    }
    
    @ViewBuilder
    private func startButton() -> some View {
        Button {
            
        } label: {
            Text("시작하기")
                .font(.body_2)
                .foregroundStyle(DesignSystemAsset.grayBlack.swiftUIColor)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(DesignSystemAsset.primary400.swiftUIColor)
        )

    }
    
    @ViewBuilder
    private func shareButton() -> some View {
        Button {
            
        } label: {
            Text("테스트 공유하기")
                .font(.body_3)
                .foregroundStyle(DesignSystemAsset.gray200.swiftUIColor)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TuringTestIntroView()
}
