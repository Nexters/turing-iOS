import ProjectDescription

let project = Project(
    name: "Profile",
    targets: [
        .target(
            name: "Profile",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.profile",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
