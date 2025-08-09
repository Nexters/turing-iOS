//
//  AuthDemoApp.swift
//  AuthDemoApp
//
//  Created by 가은 on 7/25/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct AuthDemoApp: App {
    private let store: StoreOf<AppFeature> = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    var body: some Scene {
        WindowGroup { ContentView(store: store) }
    }
}
