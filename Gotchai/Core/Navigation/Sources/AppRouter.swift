//
//  AppRouter.swift
//  Navigation
//
//  Created by koreamango on 8/2/25.
//

public struct AppRouter {
    public var navigate: @Sendable (_ route: AppRoute) async throws -> Void

    public init(navigate: @escaping @Sendable (_ route: AppRoute) async throws -> Void) {
      self.navigate = navigate
    }
}
