import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Home",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Home",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.home",
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
