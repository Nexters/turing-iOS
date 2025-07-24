import ProjectDescription

let project = Project(
    name: "Auth",
    targets: [
        .target(
            name: "Auth",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.gotchai.auth",
            infoPlist: "Info.plist",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKUser")
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: "../../../Tuist/Configurations/Config.xcconfig"),
                    .release(name: "Release", xcconfig: "../../../Tuist/Configurations/Config.xcconfig")
            ])
        )
    ]
)
