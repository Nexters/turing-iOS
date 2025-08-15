//
//  BadgeListFeature.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import ComposableArchitecture
import SwiftUI
import Combine

@Reducer
struct BadgeListFeature {
    @Dependency(\.badgeService) var badgeService

    @ObservableState
    struct State {
        var badgeItems: [Badge] = []
        var isLoading = false
        var error: String?
    }

    enum Action {
        case task                  // 뷰 등장/갱신 트리거
        case refresh               // 당겨서 새로고침 등
        case badgesLoaded([Badge])
        case failed(String)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .task, .refresh:
                state.isLoading = true
                state.error = nil
                return .publisher {
                    badgeService.fetchBadges()
                        .tryMap { dto -> [Badge] in
                            guard dto.isSuccess else {
                                throw BadgeListError.server(status: dto.status)
                            }
                            return dto.data.badges.map(Badge.init(dto:))
                        }
                        .map(BadgeListFeature.Action.badgesLoaded)
                        .catch { Just(.failed($0.localizedDescription)) }
                }

            case .badgesLoaded(let items):
                state.isLoading = false
                state.badgeItems = items
                return .none

            case .failed(let message):
                state.isLoading = false
                state.error = message
                return .none
            }
        }
    }
}
