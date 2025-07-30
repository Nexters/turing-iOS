//
//  SignInView.swift
//  SignIn
//
//  Created by koreamango on 7/30/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct SignInView: View {
  let store: StoreOf<SignInFeature>

  public init(store: StoreOf<SignInFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(spacing: 40) {
        Spacer()

        VStack(spacing: 16) {
          Image("logo", bundle: .module)

          Text("인간 사이 숨은 AI 찾기")
            .foregroundColor(.gray)
        }

        Spacer()

        VStack(spacing: 16) {
          Button {
            viewStore.send(.signInButtonTapped(.kakao))
          } label: {
            HStack {
              Image(systemName: "message.fill")
              Text("카카오로 시작하기")
                .bold()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(40)
          }

          Button {
            viewStore.send(.signInButtonTapped(.apple))
          } label: {
            HStack {
              Image(systemName: "apple.logo")
              Text("Apple로 시작하기")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(DesignSystemAsset.gray800.swiftUIColor)
            .foregroundColor(.white)
            .cornerRadius(40)
          }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
      }
      .background(DesignSystemAsset.gray950.swiftUIColor)
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView(
      store: StoreOf<SignInFeature>(
          initialState: SignInFeature.State()
      ) {
        SignInFeature()
      }
    )
  }
}
