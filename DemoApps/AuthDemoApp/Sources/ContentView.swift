//
//  ContentView.swift
//  AuthDemoAppManifests
//
//  Created by 가은 on 7/25/25.
//

import Auth
import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AuthFeature>
    
    var body: some View {
        Button("애플 로그인") {
            store.send(.loginButtonTapped(.apple))
        }
    }
}

