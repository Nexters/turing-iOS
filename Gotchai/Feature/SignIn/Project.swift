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
            resources: [],
            dependencies: [
              .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
