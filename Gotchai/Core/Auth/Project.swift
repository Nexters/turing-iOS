import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Auth",
    settings: .projectSettings,
    targets: [
        .target(
            name: "Auth",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.gotchai.auth",
            infoPlist: "Info.plist",
            sources: ["Sources/**"],
            entitlements: "../../App/Gotchai.entitlements",
            dependencies: [
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKUser")
            ]
        )
    ]
)
