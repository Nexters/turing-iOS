import ProjectDescription

let project = Project(
    name: "Network",
    targets: [
        .target(
            name: "Network",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.network",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Moya"),
                .external(name: "CombineMoya")
                .project(target: "Common", path: .relativeToRoot("Gotchai/Core/Common")),
            ]
        )
    ]
)

