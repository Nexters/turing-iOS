import ProjectDescription

let project = Project(
    name: "Main",
    targets: [
        .target(
            name: "Main",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.main",
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "CasePaths")
            ],
            settings: .settings(
                base: [
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0",
                    "DEVELOPMENT_TEAM": "$(DEVELOPMENT_TEAM)"
                ],
                configurations: [
                    .debug(name: "Debug", xcconfig: "../../../Tuist/Configurations/Config.xcconfig"),
                    .release(name: "Release", xcconfig: "../../../Tuist/Configurations/Config.xcconfig")
            ])
        )
    ]
)
