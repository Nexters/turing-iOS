// File: Color+Gotchai.swift

import SwiftUI

// File: GotchaiColor.swift
import SwiftUI

public enum GotchaiColor: String {
  case gray_black
  case gray_white
  case gray_50
  case gray_100
  case gray_200
  case gray_300
  case gray_400
  case gray_500
  case gray_600
  case gray_700
  case gray_800
  case gray_850
  case gray_900
  case gray_950

  case primary_100
  case primary_200
  case primary_300
  case primary_400
  case primary_500
  case primary_600
  case primary_700
  case primary_800
  case primary_900
  case primary_950

  case sub_blue
  case sub_red
}

public extension Color {
  init(_ gotchaiColor: GotchaiColor) {
    self.init(gotchaiColor.rawValue)
  }
}
