//
//  BadgeListFeature.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct BadgeListFeature {
    @ObservableState
    struct State {
        var badgeItems: [Badge] = Badge.dummyList
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            }
        }
    }
}
