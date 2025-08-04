//
//  CTAButton.swift
//  DesignSystem
//
//  Created by 가은 on 8/4/25.
//

import SwiftUI

public struct CTAButton: View {
    let text: String
    let action: () -> Void
    
    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity)
                .fontStyle(.body_2)
                .foregroundStyle(.grayBlack)
                .padding(.vertical, 15)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.primary400)
        )
    }
}

#Preview {
    CTAButton(text: "다음", action: { })
}
