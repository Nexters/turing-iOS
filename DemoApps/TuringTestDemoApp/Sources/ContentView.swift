//
//  ContentView.swift
//  TuringTestDemoAppManifests
//
//  Created by 가은 on 8/7/25.
//

import TCA
import SwiftUI
import Main

struct ContentView: View {
    var body: some View {
        TuringTestIntroView(store: Store(initialState: TuringTestFeature.State(), reducer: {
            TuringTestFeature()
        }))
    }
}
