import ProjectDescription

let project = Project(
    name: "Entity",
    targets: [
        .target(
            name: "Entity",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.entity",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
