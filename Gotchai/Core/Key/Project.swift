import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Key",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Key",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.key",
            sources: ["Sources/**"],
            dependencies: [
              .project(target: "Common", path: .relativeToRoot("Gotchai/Core/Common")),
              .project(target: "TCA", path: .relativeToRoot("Gotchai/Core/Third/TCA")),
            ]
        )
    ]
)

