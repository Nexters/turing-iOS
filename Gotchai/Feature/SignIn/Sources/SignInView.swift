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

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                VStack(spacing: 4) {
                    Image("logo", bundle: .module)
                    Text("인간 사이 숨은 AI 찾기")
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
                .bold()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor(red: 254, green: 229, blue: 0, alpha: 1)))
            .foregroundColor(.black)
            .cornerRadius(40)
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
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
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

