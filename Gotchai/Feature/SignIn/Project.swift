import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "SignIn",
    settings: .projectSettings,
    targets: [
        .target(
            name: "SignIn",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.signin",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
              .project(target: "DesignSystem", path: .relativeToRoot("Gotchai/Shared/DesignSystem")),
              .project(target: "Auth", path: .relativeToRoot("Gotchai/Core/Auth")),
              .project(target: "TCA", path: .relativeToRoot("Gotchai/Core/Third/TCA"))
            ]
        )
    ]
)
