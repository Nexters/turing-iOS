//
//  ProfileFeature.swift
//  Profile
//
//  Created by koreamango on 8/15/25.
//

import Combine
import TCA

@Reducer
public struct ProfileFeature {
    @Dependency(\.profileService) var profileService
    
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
        // life cycle
        case onAppear
        
        case tappedBadgeComponent
        case tappedSolvedTuringTestComponent

        case delegate(Delegate)
        
        case getRankingResponse(Result<Profile, Error>)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .publisher {
                    profileService.getRanking()
                        .map { .getRankingResponse(.success($0)) }
                        .catch { Just(.getRankingResponse(.failure($0)))}
                }
            case .tappedBadgeComponent:
                return .send(.delegate(.openMyBadgeList))
            case .tappedSolvedTuringTestComponent:
                return .send(.delegate(.openMySovledTuringTestList))
                
            case .getRankingResponse(let result):
                switch result {
                case .success(let profile):
                    return .none
                case .failure(let error):
                    return .none
                }

            case .delegate: return .none
            }
        }
    }
}
