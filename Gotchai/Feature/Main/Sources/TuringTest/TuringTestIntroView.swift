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
                .fontStyle(.title_2)
                .foregroundStyle(Color(.primary_400))
                .padding(.top, 12)
            Text("산타는 누구야?")
                .fontStyle(.title_4)
                .foregroundStyle(Color(.gray_white))
                .padding(.top, 2)
            Text("Ai가 한 말은 무엇일까요?")
                .fontStyle(.body_3)
                .foregroundStyle(Color(.gray_300))
                .padding(.top, 24)
            Image("")
                .frame(width: 305, height: 305)
                .background(
                    Circle().fill(Color(.gray_800))
                )
                .padding(.top, 44)
            
            VStack(spacing: 12) {
                StartButton()
                ShareButton()
            }
            .padding(.top, 52)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.gray_950))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("icon_arrow_back", bundle: .module)
                    .padding(12)
            }
        }
    }
    
    @ViewBuilder
    private func StartButton() -> some View {
        Button {
            
        } label: {
            Text("시작하기")
                .fontStyle(.body_2)
                .foregroundStyle(Color(.gray_black))
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.primary_400))
        )

    }
    
    @ViewBuilder
    private func ShareButton() -> some View {
        Button {
            
        } label: {
            Text("테스트 공유하기")
                .fontStyle(.body_3)
                .foregroundStyle(Color(.gray_200))
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TuringTestIntroView()
}
