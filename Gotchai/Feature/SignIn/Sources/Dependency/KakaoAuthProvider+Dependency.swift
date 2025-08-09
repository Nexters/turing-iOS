//
//  KakaoAuthProvider+Dependency.swift
//  Auth
//
//  Created by koreamango on 8/4/25.
//

import ComposableArchitecture
import Auth
import Foundation

extension KakaoAuthProvider: DependencyKey {
    public static let liveValue: KakaoAuthProvider = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String else {
            fatalError("❌ KAKAO_NATIVE_APP_KEY is missing in Info.plist")
        }
        return KakaoAuthProvider(appKey: key)
    }()
}

public extension DependencyValues {
    var kakaoAuthProvider: KakaoAuthProvider {
        get { self[KakaoAuthProvider.self] }
        set { self[KakaoAuthProvider.self] = newValue }
    }
}
