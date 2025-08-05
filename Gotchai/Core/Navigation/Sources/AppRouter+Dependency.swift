//
//  AppRouter+Dependency.swift
//  AuthDemoApp
//
//  Created by koreamango on 8/5/25.
//

import ComposableArchitecture

extension AppRouter: DependencyKey {
    public static let liveValue: AppRouter = {
        return AppRouter { route in

        }
    }()
}

public extension DependencyValues {
    var appRouter: AppRouter {
        get { self[AppRouter.self] }
        set { self[AppRouter.self] = newValue }
    }
}
