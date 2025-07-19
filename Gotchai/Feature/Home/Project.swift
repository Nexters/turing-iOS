import ProjectDescription

let project = Project(
    name: "Home",
    targets: [
        .target(
            name: "Home",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.home",
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
