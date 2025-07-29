//
//  MainView.swift
//  Main
//
//  Created by 가은 on 7/27/25.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MainView(
        store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        })
    )
}
