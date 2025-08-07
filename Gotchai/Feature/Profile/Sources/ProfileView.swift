//
//  ProfileView.swift
//  Profile
//
//  Created by 가은 on 8/7/25.
//

import DesignSystem
import SwiftUI

public struct ProfileView: View {
    
    public init() { }
    
    public var body: some View {
        VStack(spacing: 12) {
            Image("profile_default", bundle: .module)
            Text("닉네임")
                .fontStyle(.body_4)
                .foregroundStyle(Color(.gray_white))
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(hex: "1E2803"))
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(.primary_600), lineWidth: 0.5)
                    }
                )
            
            RankCard()
                .padding(.top, 12)
            MyBadgeCard()
            MyTestCard()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.gray_950))
    }
    
    
    @ViewBuilder
    private func RankCard() -> some View {
        Image("rank_card5", bundle: .module)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("닉네임님은")
                        .fontStyle(.body_6)
                        .foregroundStyle(Color(.gray_white).opacity(0.6))
                    Text("상위 5%")
                        .fontStyle(.subtitle_2)
                        .foregroundStyle(Color(.gray_white))
                }
                .padding(20)
            }
    }
    
    @ViewBuilder
    private func MyBadgeCard() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image("icon_badge", bundle: .module)
                Text("내 배지")
                Spacer()
                Button {
                    
                } label: {
                    Image("arrow_right", bundle: .module)
                        .padding(.vertical, 8)
                        .padding(.leading, 14)
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(.gray_500))
                .padding(.top, 8)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("기계사냥꾼")
                    Text("7월 16일에 획득")
                        .fontStyle(.body_6)
                        .foregroundStyle(Color(.gray_500))
                }
                Spacer()
                AsyncImage(url: URL(string: ""))
                    .frame(width: 95, height: 95)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top, 20)
        }
        .fontStyle(.body_2)
        .foregroundStyle(Color(.gray_white))
        .padding([.horizontal, .bottom], 20)
        .padding(.top, 12)
        .background(Color(.gray_900))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    @ViewBuilder
    private func MyTestCard() -> some View {
        HStack(spacing: 8) {
            Image("icon_history", bundle: .module)
            Text("내가 풀었던 테스트")
                .fontStyle(.body_2)
                .foregroundStyle(Color(.gray_white))
            
            Spacer()
            
            Button {
                
            } label: {
                Image("arrow_right", bundle: .module)
                    .padding(.vertical, 8)
                    .padding(.leading, 14)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.gray_900))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ProfileView()
}
