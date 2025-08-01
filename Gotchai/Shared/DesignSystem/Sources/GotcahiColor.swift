// File: Color+Gotchai.swift

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

private let gotchaiToDesignSystemMap: [GotchaiColor: Color] = [
  .gray_black: DesignSystemAsset.grayBlack.swiftUIColor,
  .gray_white: DesignSystemAsset.grayWhite.swiftUIColor,
  .gray_50: DesignSystemAsset.gray50.swiftUIColor,
  .gray_100: DesignSystemAsset.gray100.swiftUIColor,
  .gray_200: DesignSystemAsset.gray200.swiftUIColor,
  .gray_300: DesignSystemAsset.gray300.swiftUIColor,
  .gray_400: DesignSystemAsset.gray400.swiftUIColor,
  .gray_500: DesignSystemAsset.gray500.swiftUIColor,
  .gray_600: DesignSystemAsset.gray600.swiftUIColor,
  .gray_700: DesignSystemAsset.gray700.swiftUIColor,
  .gray_800: DesignSystemAsset.gray800.swiftUIColor,
  .gray_850: DesignSystemAsset.gray850.swiftUIColor,
  .gray_900: DesignSystemAsset.gray900.swiftUIColor,
  .gray_950: DesignSystemAsset.gray950.swiftUIColor,

  .primary_100: DesignSystemAsset.primary100.swiftUIColor,
  .primary_200: DesignSystemAsset.primary200.swiftUIColor,
  .primary_300: DesignSystemAsset.primary300.swiftUIColor,
  .primary_400: DesignSystemAsset.primary400.swiftUIColor,
  .primary_500: DesignSystemAsset.primary500.swiftUIColor,
  .primary_600: DesignSystemAsset.primary600.swiftUIColor,
  .primary_700: DesignSystemAsset.primary700.swiftUIColor,
  .primary_800: DesignSystemAsset.primary800.swiftUIColor,
  .primary_900: DesignSystemAsset.primary900.swiftUIColor,
  .primary_950: DesignSystemAsset.primary950.swiftUIColor,

  .sub_blue: DesignSystemAsset.subBlue.swiftUIColor,
  .sub_red: DesignSystemAsset.subRed.swiftUIColor
]

public extension Color {
  init(_ gotchaiColor: GotchaiColor) {
    self = gotchaiToDesignSystemMap[gotchaiColor] ?? Color.clear
  }
}
