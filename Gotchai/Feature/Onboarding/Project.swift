import ProjectDescription

let project = Project(
    name: "Onboarding",
    targets: [
        .target(
            name: "Onboarding",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.onboarding",
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
