import ProjectDescription

let project = Project(
    name: "SignIn",
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
