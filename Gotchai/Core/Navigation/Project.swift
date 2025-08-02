import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Navigation",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Navigation",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.navigation",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)

