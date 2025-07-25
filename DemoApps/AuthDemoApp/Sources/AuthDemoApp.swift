//
//  AuthDemoApp.swift
//  AuthDemoApp
//
//  Created by 가은 on 7/25/25.
//

import Auth
import ComposableArchitecture
import SwiftUI

@main
struct AuthDemoApp: App {
    let store: Store<AuthFeature.State, AuthFeature.Action> = Store(
        initialState: AuthFeature.State(),
        reducer: {
            AuthFeature()
        }
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
