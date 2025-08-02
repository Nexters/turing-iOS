// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "ComposableArchitecture": .framework
  ]
)
#endif

let package = Package(
    name: "Gotchai",
    dependencies: [
      .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.24.5"),
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.17.0"),
      .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
    ],
    targets: [
        .target(
            name: "CombineMoya",
            dependencies: ["CombineMoya"]),
        .target(name: "ComposableArchitecture",
                dependencies: [
                  .product(
                  name: "ComposableArchitecture",
                  package: "swift-composable-architecture")
                ])
    ]
)
