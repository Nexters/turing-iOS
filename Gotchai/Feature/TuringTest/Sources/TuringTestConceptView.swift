//
//  TuringTestConceptView.swift
//  TuringTest
//
//  Created by 가은 on 7/30/25.
//

import DesignSystem
import SwiftUI

struct TuringTestConceptView: View {
    var body: some View {
        VStack {
            Text("""
                크리스마스 이브 밤,  친구들과의 랜선 파티에 초대된 당신.  모두가 산타 모자를 쓰고 등장했지만…  그 중 하나는 사람처럼 말하는 AI?!

                이제 당신의 임무는  대화 속에서 AI의 말투를 간파하는 것!  과연 진짜 친구와 AI 산타,
                구분할 수 있을까요?
                """)
            .font(.body_1)
            .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
            .multilineTextAlignment(.center)
            .padding(.top, 32)
            
            Spacer()
            
            nextButton()
                .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystemAsset.gray950.swiftUIColor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image("icon_xmark", bundle: .module)
                    .padding(12)
            }
        }
    }
    
    @ViewBuilder
    private func nextButton() -> some View {
        Button {
            
        } label: {
            Text("다음")
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
}

#Preview {
    TuringTestConceptView()
}
