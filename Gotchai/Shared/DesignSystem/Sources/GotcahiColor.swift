// File: Color+Gotchai.swift

import SwiftUI

// File: GotchaiColor.swift
import SwiftUI

public enum GotchaiColor: String {
  case gray_black
  case gray_white
  case gray50
  case gray100
  case gray200
  case gray300
  case gray400
  case gray500
  case gray600
  case gray700
  case gray800
  case gray850
  case gray900
  case gray950

  case primary100
  case primary200
  case primary300
  case primary400
  case primary500
  case primary600
  case primary700
  case primary800
  case primary900
  case primary950

  case sub_blue
  case sub_red
}

public extension Color {
  init(_ gotchaiColor: GotchaiColor) {
    self.init(gotchaiColor.rawValue)
  }
}
