//
//  ContentView.swift
//  AuthDemoAppManifests
//
//  Created by 가은 on 7/25/25.
//


import ComposableArchitecture
import SwiftUI
import SignIn
import Auth

struct ContentView: View {
  let kakaoAuthProvider: KakaoAuthProvider = .init(appKey: "")
  let appleAuthProvider: AppleAuthProvider = .init()

    var body: some View {
      SignInView(store: StoreOf<SignInFeature>(
        initialState: SignInFeature.State(),
        reducer: {
          SignInFeature(kakaoAuthProvider: kakaoAuthProvider, appleAuthProvider: appleAuthProvider)
        })
      )
    }
}
