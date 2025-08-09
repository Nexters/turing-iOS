//
//  TuringTestConceptView.swift
//  TuringTest
//
//  Created by 가은 on 7/30/25.
//

import TCA
import DesignSystem
import SwiftUI

struct TuringTestConceptView: View {
    let store: StoreOf<TuringTestFeature>
    
    var body: some View {
        VStack {
            Text("""
                \(store.turingTest.explanation)
                """)
            .fontStyle(.body_1)
            .foregroundStyle(Color(.gray_white))
            .multilineTextAlignment(.center)
            .padding(.top, 32)
            
            Spacer()
            
            CTAButton(text: "다음") {
                store.send(.moveToQuizView)
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.gray_950))   // TODO: 이미지로 변경
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image("icon_xmark", bundle: .module)
                    .padding(12)
            }
        }
    }
}

#Preview {
    TuringTestConceptView(store: Store(initialState: TuringTestFeature.State(), reducer: {
        TuringTestFeature()
    }))
}
