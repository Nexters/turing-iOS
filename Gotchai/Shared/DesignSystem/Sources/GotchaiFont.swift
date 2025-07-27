import SwiftRichString
import Foundation

public enum Typography {

    /// 공통 스타일 생성 함수
    private static func style(font: FontConvertible,
                              lineHeightMultiple: CGFloat = 1.5,
                              kerningPercent: CGFloat = -3) -> Style {
        return Style {
            $0.font = font
            $0.lineSpacing = lineHeightMultiple
            $0.kerning = .adobe(kerningPercent * 10) // -3% → adobe -30
        }
    }

    // MARK: - Titles
    public static let title1 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 36))
    public static let title2 = style(font: DesignSystemFontFamily.PretendardVariable.bold.font(size: 30))
    public static let title3 = style(font: DesignSystemFontFamily.PretendardVariable.bold.font(size: 26))
    public static let title4 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 24))

    // MARK: - Subtitles
    public static let subtitle1 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 22))
    public static let subtitle2 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 20))

    // MARK: - Body
    public static let body1 = style(font: DesignSystemFontFamily.PretendardVariable.medium.font(size: 18))
    public static let body2 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 18))
    public static let body3 = style(font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 16))
    public static let body4 = style(font: DesignSystemFontFamily.PretendardVariable.medium.font(size: 16))
    public static let body5 = style(font: DesignSystemFontFamily.PretendardVariable.medium.font(size: 15))
    public static let body6 = style(font: DesignSystemFontFamily.PretendardVariable.medium.font(size: 14))
}
