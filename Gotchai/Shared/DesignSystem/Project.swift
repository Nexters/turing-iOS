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
            dependencies: []
        )
    ]
)
