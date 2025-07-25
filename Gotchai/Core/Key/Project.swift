import ProjectDescription

let project = Project(
    name: "Key",
    targets: [
        .target(
            name: "Key",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.key",
            sources: ["Sources/**"],
            dependencies: [
              .project(target: "Common", path: .relativeToRoot("Gotchai/Core/Common")),
            ]
        )
    ]
)
