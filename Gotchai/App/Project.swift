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
            bundleId: "com.gotchai.Gotchai",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Onboarding", path: .relativeToRoot("Gotchai/Feature/Onboarding")),
                .project(target: "Profile", path: .relativeToRoot("Gotchai/Feature/Profile")),
                .project(target: "Home", path: .relativeToRoot("Gotchai/Feature/Home")),
                .project(target: "SignIn", path: .relativeToRoot("Gotchai/Feature/SignIn")),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
