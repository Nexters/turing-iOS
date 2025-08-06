import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Gotchai",
    settings: .projectSettings,
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
                .project(target: "Main", path: .relativeToRoot("Gotchai/Feature/Main")),
                .project(target: "SignIn", path: .relativeToRoot("Gotchai/Feature/SignIn"))
            ]
        )
    ]
)
