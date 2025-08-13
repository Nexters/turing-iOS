import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Setting",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Setting",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.setting",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "DesignSystem", path: .relativeToRoot("Gotchai/Shared/DesignSystem")),
                .project(target: "TCA", path: .relativeToRoot("Gotchai/Core/Third/TCA"))
            ]
        )
    ]
)
