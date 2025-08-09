import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Profile",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Profile",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.profile",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "TCA", path: .relativeToRoot("Gotchai/Core/Third/TCA"))
            ]
        )
    ]
)
