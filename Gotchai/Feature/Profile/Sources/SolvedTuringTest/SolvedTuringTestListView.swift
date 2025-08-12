//
//  SolvedTuringTestListView.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import SwiftUI

struct SolvedTuringTestListView: View {
    @State private var solvedTestItems: [SolvedTuringTest] = SolvedTuringTest.dummyList
    
    var body: some View {
        ZStack {
            Color(.gray_950).ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(solvedTestItems,id: \.id) { item in
                        TestCard(data: item)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func TestCard(data: SolvedTuringTest) -> some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: data.iconURL))
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(data.title)
                    .foregroundStyle(Color(.gray_white))
                Text("\(data.totalQuizCount)개 중 \(data.correctCount)개 맞췄어요")
                    .foregroundStyle(Color(.gray_500))
            }
            
            Spacer()
            Text("\(data.percent)%")
                .foregroundStyle(Color(.sub_blue))
        }
        .fontStyle(.body_4)
        .padding(.horizontal, 20)
        .padding(.vertical, 23)
        .background(Color(.gray_900))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SolvedTuringTestListView()
}
