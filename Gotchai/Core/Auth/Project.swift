import ProjectDescription

let project = Project(
    name: "Auth",
    targets: [
        .target(
            name: "Auth",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.auth",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
