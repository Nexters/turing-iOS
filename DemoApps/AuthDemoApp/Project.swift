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
            dependencies: [
                .project(target: "SignIn", path: .relativeToRoot("Gotchai/Feature/SignIn")),
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig")),
                    .release(name: "Release", xcconfig: .relativeToRoot("Tuist/Configurations/Config.xcconfig"))
            ])
        )
    ]
)

