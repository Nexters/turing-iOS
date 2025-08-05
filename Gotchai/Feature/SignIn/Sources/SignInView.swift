//
//  SignInView.swift
//  SignIn
//
//  Created by koreamango on 7/30/25.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Auth

public struct SignInView: View {
    let store: StoreOf<SignInFeature>

    public init(store: StoreOf<SignInFeature>) {
        self.store = store
    }

    var kakaoButtonColor: Color =
            Color(red: 254.0 / 255.0, green: 229.0 / 255.0, blue: 0.0 / 255.0)
    var kakaoButtonTextColor: Color =
            Color(red: 25.0 / 255.0, green: 22.0 / 255.0, blue: 0.0 / 255.0)
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                VStack(spacing: 4) {
                    Image("logo", bundle: .module)
                    Text("인간 사이 숨은 AI 찾기")
                        .fontStyle(FontStyle.body_2)
                        .foregroundColor(Color(.gray_200))
                }
                Spacer(minLength: 300)
                VStack(spacing: 16) {
                    Button {
                        viewStore.send(.tappedKakaoLogin)
                    } label: {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("카카오로 시작하기")
                                .fontStyle(FontStyle.body_2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(kakaoButtonColor)
                        .foregroundColor(kakaoButtonTextColor)
                        .cornerRadius(50)
                    }

                    Button {
                        viewStore.send(.tappedAppleLogin)
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                            Text("Apple로 시작하기")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.gray_800))
                        .foregroundColor(Color(.gray_white))
                        .cornerRadius(50)
                    }
                }
                .padding(.horizontal, 33)
                .padding(.bottom, 125)
            }
            .background(Color(.gray_950))
        }
    }
}

#Preview {
    SignInView(store: StoreOf<SignInFeature>(
        initialState: SignInFeature.State(),
        reducer: {
            SignInFeature(kakaoAuthProvider: KakaoAuthProvider(appKey: ""), appleAuthProvider: AppleAuthProvider())
        })
    )
}

