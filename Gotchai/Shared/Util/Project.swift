import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Util",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Util",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.util",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
