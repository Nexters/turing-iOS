import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Network",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Network",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.gotchai.network",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Moya"),
                .external(name: "CombineMoya"),
                .project(target: "Common", path: .relativeToRoot("Gotchai/Core/Common")),
            ]
        )
    ]
)

