//
//  OnboardingView.swift
//  Onboarding
//
//  Created by koreamango on 7/28/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct OnboardingView: View {
  public let store: StoreOf<OnboardingFeature> 

  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        DesignSystemAsset.gray950.swiftUIColor
          .ignoresSafeArea()

        VStack {
          HStack {
            Spacer()
            Button("건너뛰기") {
              viewStore.send(.start)
            }
            .foregroundColor(DesignSystemAsset.gray400.swiftUIColor)
            .padding()
          }

          Spacer()

          TabView(selection: viewStore.binding(
            get: \.currentPage,
            send: OnboardingFeature.Action.pageChanged
          )) {
            ForEach(Array(viewStore.pages.enumerated()), id: \.offset) {
 idx,
 page in
              VStack(spacing: 24) {
                Image(page.imageName)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 300, height: 300)
                  .cornerRadius(16)

                Text(page.title)
                  .foregroundColor(DesignSystemAsset.grayWhite.swiftUIColor)
                  .multilineTextAlignment(.center)
                  .padding(.horizontal, 32)
              }
              .tag(idx)
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          .frame(height: 400)

          HStack(spacing: 8) {
            ForEach(0..<viewStore.pages.count, id: \.self) { idx in
              Circle()
                .fill(
                  idx == viewStore.currentPage ?
                    DesignSystemAsset.primary400.swiftUIColor :
                    DesignSystemAsset.gray700.swiftUIColor
                )
                .frame(width: 8, height: 8)
            }
          }
          .padding(.vertical, 24)

          Spacer()

          Button {
            viewStore.send(.nextButtonTapped)
          } label: {
            Text(viewStore.currentPage < viewStore.pages.count - 1 ? "다음" : "시작하기")
              .bold()
              .frame(maxWidth: .infinity)
              .padding()
              .background(DesignSystemAsset.primary400.swiftUIColor)
              .cornerRadius(12)
              .foregroundColor(.black)
          }
          .padding(.horizontal, 24)
          .padding(.bottom, 40)
        }
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(
      store: StoreOf<OnboardingFeature>(
        initialState: OnboardingFeature.State()
      ) {
        OnboardingFeature()
      }
    )
  }
}
