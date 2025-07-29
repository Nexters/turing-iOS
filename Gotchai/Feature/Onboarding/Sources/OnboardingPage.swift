import ComposableArchitecture
import SwiftUI

public struct OnboardingPage: Equatable {
  public let imageName: String
  public let title: String

  public init(imageName: String, title: String) {
    self.imageName = imageName
    self.title = title
  }
}
