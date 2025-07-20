import ProjectDescription

let project = Project(
    name: "Common",
    targets: [
        .target(
            name: "Common",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.common",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)

