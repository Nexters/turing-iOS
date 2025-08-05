import SwiftUI

public enum FontStyle {
    case title_1, title_2, title_3, title_4
    case subtitle_1, subtitle_2
    case body_1, body_2, body_3, body_4, body_5, body_6

    public var fontSize: CGFloat {
        switch self {
        case .title_1: return 36
        case .title_2: return 30
        case .title_3: return 26
        case .title_4: return 24
        case .subtitle_1: return 22
        case .subtitle_2: return 20
        case .body_1, .body_2: return 18
        case .body_3, .body_4: return 16
        case .body_5: return 15
        case .body_6: return 14
        }
    }

    public var uiFont: UIFont {
        switch self {
        case .title_1: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)
        case .title_2: return DesignSystemFontFamily.PretendardVariable.bold.font(size: fontSize)
        case .title_3: return DesignSystemFontFamily.PretendardVariable.bold.font(size: fontSize)
        case .title_4: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)

        case .subtitle_1: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)
        case .subtitle_2: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)

        case .body_1: return DesignSystemFontFamily.PretendardVariable.medium.font(size: fontSize)
        case .body_2: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)
        case .body_3: return DesignSystemFontFamily.PretendardVariable.semiBold.font(size: fontSize)
        case .body_4: return DesignSystemFontFamily.PretendardVariable.medium.font(size: fontSize)
        case .body_5: return DesignSystemFontFamily.PretendardVariable.medium.font(size: fontSize)
        case .body_6: return DesignSystemFontFamily.PretendardVariable.medium.font(size: fontSize)
        }
    }

    public var font: Font { Font(uiFont) }

    public var letterSpacing: CGFloat { fontSize * -0.03 }

    public var lineHeight: CGFloat { fontSize * 1.5 }
}

public extension View {
    func fontStyle(_ style: FontStyle) -> some View {
        let spacing = style.lineHeight - style.uiFont.lineHeight

        return font(style.font)
            .kerning(style.letterSpacing)
            .lineSpacing(spacing)
            .padding(.vertical, spacing / 2)
    }
}
