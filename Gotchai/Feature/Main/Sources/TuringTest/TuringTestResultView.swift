//
//  TuringTestResultView.swift
//  Main
//
//  Created by 가은 on 8/7/25.
//

import DesignSystem
import SwiftUI
import TCA

public struct TuringTestResultView: View {
    let store: StoreOf<TuringTestFeature>
    let gradientStops = GradientHelper.getGradientStops(for: .gold)
    let badgeCardColor = GradientHelper.getBadgeColors(for: .gold)
    
    public init(store: StoreOf<TuringTestFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Color(.gray_900).ignoresSafeArea()
            BackgroundGradient()
            
            ScrollView {
                VStack(spacing: 24) {
                    BadgeCard()
                    PromptCard()
                }
                .padding(.horizontal, 36)
                .padding(.bottom, 126)
                .padding(.top, 68)
            }
            
            VStack {
                TopNaviBar()
                Spacer()
            }
            
            BottomButtons()
        }
        
    }
    
    @ViewBuilder
    private func TopNaviBar() -> some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Image("icon_xmark", bundle: .module)
                    .padding(12)
            }
            .padding(.trailing, 12)
            .padding(.bottom, 20)
        }
        .gradientBackground(
            stops: gradientStops.naviBackground,
            startPoint: .top,
            endPoint: .bottom)
    }
    
    @ViewBuilder
    private func BadgeCard() -> some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: ""))
                .frame(width: 213, height: 213)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            Text("모두 맞춘 당신은")
                .fontStyle(.body_1)
                .foregroundStyle(Color(hex: badgeCardColor.subColor))
                .padding(.top, 26)
            Text("Ai 산타 감별사")
                .fontStyle(.title_3)
                .foregroundStyle(Color(hex: badgeCardColor.titleColor))
            Text("크리스마스엔 선물보다\n눈치가 중요하다는 걸 증명했어요!")
                .fontStyle(.body_4)
                .foregroundStyle(Color(.gray_white).opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            Image(badgeCardColor.image, bundle: .module)
                .padding(.top, 36)
        }
        .padding([.horizontal, .top], 34)
        .padding(.bottom, 27)
        .frame(maxWidth: .infinity)
        .gradientBackground(
            stops: gradientStops.badgeLinearBackground,
            startPoint: .topLeading,
            endPoint: .bottomTrailing,
            cornerRadius: 24,
            strokeColor: Color(.gray_white).opacity(0.2),
            backgroundOpacity: 0.2
        )
        .background(
            RadialGradient(
                gradient: Gradient(stops: gradientStops.badgeRadialBackground),
                center: .bottom,
                startRadius: 0,
                endRadius: 400
            ).opacity(0.2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    @ViewBuilder
    private func PromptCard() -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("GPT")
                    .fontStyle(.body_5)
                    .foregroundStyle(Color(.gray_white).opacity(0.5))
            }
            .padding(.top, 18)
            Text("Ai산타")
                .fontStyle(.subtitle_2)
                .foregroundStyle(Color(.primary_300))
            Text("이 프롬프트로 만들었어요")
                .fontStyle(.subtitle_1)
            AsyncImage(url: URL(string: ""))
                .frame(width: 133, height: 133)
                .clipShape(Circle())
                .padding(.vertical, 16)
            Text("AI 산타 캐릭터를 만들거야. MBTI는 ESFP이고, 20대 초중반 정도의 젊은 산타였으면 좋겠어. 선물 고르는 센스가 남다르고, 공감을 잘하는 성격을 가진 캐릭터로 설정해줘.")
                .fontStyle(.body_4)
                .multilineTextAlignment(.center)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(.gray_500))
                .padding(.top, 32)
            Button {
                
            } label: {
                HStack {
                    Image("", bundle: .module)
                    Text("프롬프트 복사하기")
                        .fontStyle(.body_3)
                        .foregroundStyle(Color(.primary_400))
                }
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 6)
        }
        .foregroundStyle(Color(.gray_white))
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(hex: "BFC9E7").opacity(0.1))
        )
    }
    
    @ViewBuilder
    private func BackgroundGradient() -> some View {
        Color.clear
            .ignoresSafeArea()
            .gradientBackground(
                stops: gradientStops.mainBackground,
                startPoint: .top,
                endPoint: .bottom
            )
    }
    
    @ViewBuilder
    private func BottomButtons() -> some View {
        HStack(alignment: .bottom, spacing: 13) {
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    Image("icon_save", bundle: .module)
                    Text("이미지 저장")
                        .fontStyle(.body_3)
                        .foregroundStyle(Color(.gray_black))
                        .padding(.vertical, 15)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color(.primary_100))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    Image("icon_insta", bundle: .module)
                    Text("배지 공유")
                        .fontStyle(.body_3)
                        .foregroundStyle(Color(.gray_black))
                        .padding(.vertical, 15)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color(.primary_400))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.top, 66)
        .padding(.horizontal, 24)
        .gradientBackground(
            stops: [
                .init(color: Color(.gray_950).opacity(0.0), location: 0.0),
                .init(color: Color(.gray_950), location: 0.5),
                .init(color: Color(.gray_950), location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    TuringTestResultView(store: Store(initialState: TuringTestFeature.State(), reducer: {
        TuringTestFeature()
    }))
}
