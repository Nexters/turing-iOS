//
//  Settings+Extension.swift
//  Tuist
//
//  Created by 가은 on 7/30/25.
//

import ProjectDescription

public extension Settings {
    static var projectSettings: Self {
        return .settings(
            base: [
                "IPHONEOS_DEPLOYMENT_TARGET": "17.0",
                "DEVELOPMENT_TEAM": "$(DEVELOPMENT_TEAM)"
            ],
            configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig"))
            ]
        )
    }
}
