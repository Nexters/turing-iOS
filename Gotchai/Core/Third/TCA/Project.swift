import ProjectDescription

let project = Project(
  name: "TCA",
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
