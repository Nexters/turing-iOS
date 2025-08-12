//
//  SettingFeature.swift
//  Setting
//
//  Created by 가은 on 8/13/25.
//

import TCA

@Reducer
public struct SettingFeature {
    
    public init() { }
    
    @ObservableState
    public struct State {
        
    }
    
    public enum Action {
        case tappedGetFeedbackButton
        case tappedTermsButton
        case tappedPolicyButton
        case tappedLogoutButton
        case tappedWithdrawButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
    }
}
