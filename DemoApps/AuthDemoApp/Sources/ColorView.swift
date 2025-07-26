//
//  ColorView.swift
//  AuthDemoApp
//
//  Created by koreamango on 7/26/25.
//

import SwiftUI

struct ColorPreviewView: View {
    var body: some View {
        VStack(spacing: 16) {
//            colorRow(name: "Primary", color: DesignSystemColor.primary)
          
        }
        .padding()
    }

    private func colorRow(name: String, color: Color) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 48, height: 48)
            Text(name)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

#Preview("Color Palette") {
    ColorPreviewView()
}

