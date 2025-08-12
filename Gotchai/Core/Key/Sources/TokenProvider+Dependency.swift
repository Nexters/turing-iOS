//
//  TokenProvider+Dependency.swift
//  Key
//
//  Created by koreamango on 8/13/25.
//

import TCA
import Common // TokenProvider 프로토콜이 여기에 있다고 가정

public enum TokenProviderKey: DependencyKey {
    public static let liveValue: TokenProvider = KeychainTokenProvider.shared
}

public extension DependencyValues {
    var tokenProvider: TokenProvider {
        get { self[TokenProviderKey.self] }
        set { self[TokenProviderKey.self] = newValue }
    }
}
