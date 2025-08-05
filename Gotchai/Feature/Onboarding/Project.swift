import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Onboarding",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Onboarding",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.onboarding",
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
              .project(target: "DesignSystem", path: .relativeToRoot("Gotchai/Shared/DesignSystem")),
              .project(target: "TCA", path: .relativeToRoot("Gotchai/Core/Third/TCA")),
              .project(target: "Navigation", path: .relativeToRoot("Gotchai/Core/Navigation"))
            ]
        )
    ]
)
