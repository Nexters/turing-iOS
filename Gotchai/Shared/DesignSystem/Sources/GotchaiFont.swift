import SwiftUI

/// - title_1: Pretendard SemiBold, size: 36
/// - title_2: Pretendard Bold, size: 30
/// - title_3: Pretendard Bold, size: 26
/// - title_4: Pretendard SemiBold, size: 24
/// - subtitle_1: Pretendard SemiBold, size: 22
/// - subtitle_2: Pretendard SemiBold, size: 20
/// - body_1: Pretendard Medium, size: 18
/// - body_2: Pretendard SemiBold, size: 18
/// - body_3: Pretendard SemiBold, size: 16
/// - body_4: Pretendard Medium, size: 16
/// - body_5: Pretendard Medium, size: 15
/// - body_6: Pretendard Medium, size: 14
public enum FontStyle {
  case title_1, title_2, title_3, title_4
  case subtitle_1, subtitle_2
  case body_1, body_2, body_3, body_4, body_5, body_6

  var font: Font {
    switch self {
    case .title_1: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 36))
    case .title_2: return Font(DesignSystemFontFamily.PretendardVariable.bold.font(size: 30))
    case .title_3: return Font(DesignSystemFontFamily.PretendardVariable.bold.font(size: 26))
    case .title_4: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 24))

    case .subtitle_1: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 22))
    case .subtitle_2: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 20))

    case .body_1: return Font(DesignSystemFontFamily.PretendardVariable.medium.font(size: 18))
    case .body_2: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 18))
    case .body_3: return Font(DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 16))
    case .body_4: return Font(DesignSystemFontFamily.PretendardVariable.medium.font(size: 16))
    case .body_5: return Font(DesignSystemFontFamily.PretendardVariable.medium.font(size: 15))
    case .body_6: return Font(DesignSystemFontFamily.PretendardVariable.medium.font(size: 14))
    }
  }
}

extension Font {
  static var title_1: Font { FontStyle.title_1.font }
  static var title_2: Font { FontStyle.title_2.font }
  static var title_3: Font { FontStyle.title_3.font }
  static var title_4: Font { FontStyle.title_4.font }

  static var subtitle_1: Font { FontStyle.subtitle_1.font }
  static var subtitle_2: Font { FontStyle.subtitle_2.font }

  static var body_1: Font { FontStyle.body_1.font }
  static var body_2: Font { FontStyle.body_2.font }
  static var body_3: Font { FontStyle.body_3.font }
  static var body_4: Font { FontStyle.body_4.font }
  static var body_5: Font { FontStyle.body_5.font }
  static var body_6: Font { FontStyle.body_6.font }
}
