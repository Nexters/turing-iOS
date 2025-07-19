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
                .external(name: "ComposableArchitecture"),
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKUser")
            ]
        )
    ]
)
