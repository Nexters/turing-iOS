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
    public struct State: Equatable {
        var isPresentedPopUp: Bool
        var popUpType: SettingPopUpType?
        
        public init(isPresentedPopUp: Bool = false, popUpType: SettingPopUpType? = nil) {
            self.isPresentedPopUp = isPresentedPopUp
            self.popUpType = popUpType
        }
    }
    
    public enum Delegate {
        case moveToMainView
    }
    
    public enum Action: Equatable {
        case tappedBackButton
        case tappedGetFeedbackButton
        case tappedTermsButton
        case tappedPolicyButton
        case logout
        case withdraw
        case showPopUp(SettingPopUpType)
        case setIsPresentedPopUp(Bool)  // 바인딩용
        case delegate(Delegate)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tappedBackButton:
                return .send(.delegate(.moveToMainView))
            case let .showPopUp(type):
                state.isPresentedPopUp = true
                state.popUpType = type
                return .none
            case let .setIsPresentedPopUp(flag):
                state.isPresentedPopUp = flag
                return .none
                
            default: return .none
            }
        }
    }
}

public enum SettingPopUpType: Equatable {
    case logout, withdraw
}
