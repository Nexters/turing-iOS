import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Common",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Common",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.common",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)

