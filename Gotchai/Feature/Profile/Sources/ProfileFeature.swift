//
//  ProfileFeature.swift
//  Profile
//
//  Created by koreamango on 8/15/25.
//

import TCA

@Reducer
public struct ProfileFeature {

    public init() { }

    @ObservableState
    public struct State {
        public init() {}
    }

    public enum Delegate {
        case openMyBadgeList
        case openMySovledTuringTestList
    }

    public enum Action {
        case tappedBadgeComponent
        case tappedSolvedTuringTestComponent

        case delegate(Delegate)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tappedBadgeComponent:
                return .send(.delegate(.openMyBadgeList))
            case .tappedSolvedTuringTestComponent:
                return .send(.delegate(.openMySovledTuringTestList))

            case .delegate: return .none
            }
        }
    }
}
