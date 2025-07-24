import ProjectDescription

import ProjectDescription

let tuist = Tuist(
  project: .tuist(
    // 필요하다면 Xcode 호환 버전도 명시할 수 있습니다.
    compatibleXcodeVersions: .all,
    // 여기서 원하는 Swift 버전을 지정
    swiftVersion: Version(5, 10, 0),
    plugins: [],
    generationOptions: .options(),
    installOptions: .options()
  )
)
