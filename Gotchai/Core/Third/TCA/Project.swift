import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "TCA",
  settings: .projectSettings,
  targets: [
    .target(
      name: "TCA",
      destinations: .iOS,
      product: .framework,
      bundleId: "com.gotchai.core.tca",
      sources: [],
      dependencies: [
        .external(name: "ComposableArchitecture")
      ]
    )
  ]
)
