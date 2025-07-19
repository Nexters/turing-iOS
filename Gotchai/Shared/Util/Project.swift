import ProjectDescription

let project = Project(
    name: "Util",
    targets: [
        .target(
            name: "Util",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.util",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
