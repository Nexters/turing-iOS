import ProjectDescription

let project = Project(
    name: "AuthDemoApp",
    targets: [
        .target(
            name: "AuthDemoApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.gotchai.authdemoapp",
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "Launch Screen"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: .relativeToRoot("DemoApps/AuthDemoApp/AuthDemoApp.entitlements")),
            dependencies: [
                .project(target: "Onboarding", path: .relativeToRoot("Gotchai/Feature/Onboarding")),
                .project(target: "Profile", path: .relativeToRoot("Gotchai/Feature/Profile")),
                .project(target: "Main", path: .relativeToRoot("Gotchai/Feature/Main")),
                .project(target: "SignIn", path: .relativeToRoot("Gotchai/Feature/SignIn"))
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig")),
                    .release(name: "Release", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig"))
            ])
        )
    ]
)

