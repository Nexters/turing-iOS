//
//  GradientBackground.swift
//  DesignSystem
//
//  Created by 가은 on 8/10/25.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    let stops: [Gradient.Stop]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    let cornerRadius: CGFloat
    let strokeColor: Color
    let lineWidth: CGFloat
    let backgroundOpacity: Double

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(stops: stops, startPoint: startPoint, endPoint: endPoint)
                    .opacity(backgroundOpacity)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}

public extension View {
    func gradientBackground(
        stops: [Gradient.Stop],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        cornerRadius: CGFloat = 0,
        strokeColor: Color = .clear,
        lineWidth: CGFloat = 1,
        backgroundOpacity: Double = 1
    ) -> some View {
        self.modifier(GradientBackground(
            stops: stops,
            startPoint: startPoint,
            endPoint: endPoint,
            cornerRadius: cornerRadius,
            strokeColor: strokeColor,
            lineWidth: lineWidth,
            backgroundOpacity: backgroundOpacity
        ))
    }
}

