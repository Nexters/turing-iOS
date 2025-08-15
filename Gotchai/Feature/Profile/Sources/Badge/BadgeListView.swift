//
//  BadgeListView.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import TCA
import SwiftUI

struct BadgeListView: View {
    let store: StoreOf<BadgeListFeature>
    
    let colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color(.gray_950).ignoresSafeArea()
            
            ScrollView {
                HStack(spacing: 12) {
                    Image("icon_congratulations", bundle: .module)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("축하해요")
                            .fontStyle(.body_6)
                            .foregroundStyle(Color(.gray_white))
                        Text("12개의 배지를 모았어요!")
                            .fontStyle(.body_2)
                            .foregroundStyle(Color(.primary_400))
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.vertical, 16)
                .background(Color(.primary_900))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)
                
                LazyVGrid(columns: colums, spacing: 16) {
                    ForEach(store.badgeItems, id: \.id) { item in
                        VStack(spacing: 12) {
                            AsyncImage(url: URL(string: item.imageURL))
                                .frame(width: 104, height: 104)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            Text(item.name)
                                .fontStyle(.body_6)
                                .foregroundStyle(Color(.gray_100))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .task { await store.send(.task).finish() }         // 화면 등장 시 1회 호출
            .refreshable { await store.send(.refresh).finish() } // 당겨서 새로고침
        }
    }
}

#Preview {
    BadgeListView(store: .init(initialState: BadgeListFeature.State(), reducer: {
        BadgeListFeature()
    }))
}
