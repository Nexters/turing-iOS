import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DesignSystem",
    settings: .projectSettings,
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.design-system",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [],
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
