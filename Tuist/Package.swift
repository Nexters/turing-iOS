// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "swift-composable-architecture": .staticFramework,
    "kakao-ios-sdk": .staticFramework
  ]
)
#endif

let package = Package(
  name: "Gotchai",
  dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.17.0"),
      .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.24.5")
  ]
)
