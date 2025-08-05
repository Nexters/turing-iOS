import ProjectDescription

let project = Project(
    name: "AuthDemoApp",
    targets: [
        .target(
            name: "AuthDemoApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.gotchai.authdemoapp",
            infoPlist: .default,
//            infoPlist: .file(path: .relativeToRoot("Gotchai/Core/Auth/Info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Onboarding", path: .relativeToRoot("Gotchai/Feature/Onboarding")),
                .project(target: "Profile", path: .relativeToRoot("Gotchai/Feature/Profile")),
                .project(target: "Home", path: .relativeToRoot("Gotchai/Feature/Home")),
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

