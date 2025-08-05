//
//  KakaoAuthProvider+Dependency.swift
//  Auth
//
//  Created by koreamango on 8/4/25.
//

import ComposableArchitecture
import Auth

extension KakaoAuthProvider: DependencyKey {
    public static let liveValue: KakaoAuthProvider = {
        return KakaoAuthProvider(appKey: "")
    }()
}

public extension DependencyValues {
    var kakaoAuthProvider: KakaoAuthProvider {
        get { self[KakaoAuthProvider.self] }
        set { self[KakaoAuthProvider.self] = newValue }
    }
}
