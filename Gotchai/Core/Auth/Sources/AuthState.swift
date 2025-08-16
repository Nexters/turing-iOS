//
//  AuthState.swift
//  Auth
//
//  Created by koreamango on 8/14/25.
//

import Foundation

public final class AuthRuntime {
    public init(
        currentSession: UserSession? = nil,
        currentProvider: AuthProvider? = nil
    ) {
        self.currentSession = currentSession
        self.currentProvider = currentProvider
    }
    private var currentSession: UserSession?
    private var currentProvider: AuthProvider?
    private let queue = DispatchQueue(label: "auth.runtime.serial")
    
    public func set(session: UserSession, provider: AuthProvider) {
        queue.sync { self.currentSession = session; self.currentProvider = provider }
    }
    public func clear() { queue.sync { self.currentSession = nil; self.currentProvider = nil } }
    public func provider() -> AuthProvider? { queue.sync { currentProvider } }
}
