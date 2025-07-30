import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "TuringTest",
    settings: .projectSettings,
    targets: [
        .target(
            name: "TuringTest",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.turingtest",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
