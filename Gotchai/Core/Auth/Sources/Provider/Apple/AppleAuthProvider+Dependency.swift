//
//  AppleAuthProvider+Dependency.swift
//  Auth
//
//  Created by koreamango on 8/4/25.
//

import TCA

extension AppleAuthProvider: DependencyKey {
    public static let liveValue: AppleAuthProvider = {
        return AppleAuthProvider()
    }()
}

public extension DependencyValues {
    var appleAuthProvider: AppleAuthProvider {
        get { self[AppleAuthProvider.self] }
        set { self[AppleAuthProvider.self] = newValue }
    }
}
