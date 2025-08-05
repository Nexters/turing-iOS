//
//  AuthDemoApp.swift
//  AuthDemoApp
//
//  Created by 가은 on 7/25/25.
//

import SwiftUI
import ComposableArchitecture
import Navigation

@main
struct AuthDemoApp: App {
  private let store: StoreOf<AppFeature>

  init() {
    // 1) placeholder 라우팅 핸들러
    var route: (AppRoute) -> Void = { _ in }

    // 2) placeholder를 사용해 의존성 주입하면서 스토어 생성
    let s = Store(initialState: AppFeature.State()) {
      AppFeature()
    } withDependencies: { dep in
      dep.appRouter = .init { r in
        await MainActor.run { route(r) }
      }
    }

    // 3) 스토어가 생성된 뒤에 실제 구현을 바인딩
    route = { [weak s] r in
      switch r {
      case .signIn:  s?.send(.routeToSignIn)
      case .onboard: break
      }
    }

    self.store = s
  }

  var body: some Scene {
    WindowGroup { ContentView(store: store) }
  }
}
