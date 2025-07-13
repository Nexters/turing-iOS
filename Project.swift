import ProjectDescription

let project = Project(
    name: "Gotchai",
    settings: .settings(
        base: [
            "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
        ]
    ),
    targets: [
        .target(
            name: "Gotchai",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Gotchai",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Gotchai/Sources/**"],
            resources: ["Gotchai/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "GotchaiTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.GotchaiTests",
            infoPlist: .default,
            sources: ["Gotchai/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Gotchai")]
        ),
    ]
)
