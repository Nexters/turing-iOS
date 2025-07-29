//
//  SegmentedPicker.swift
//  Main
//
//  Created by 가은 on 7/29/25.
//

import DesignSystem
import SwiftUI

struct SegmentedPicker: View {
    @Binding var selectedTab: Tab
    let width: CGFloat = 83
    let itemSpacing: CGFloat = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: itemSpacing) {
                ForEach(Array(Tab.allCases), id: \.rawValue) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        Text(tab.rawValue)
                            .font(selectedTab == tab ? .body_2 : .body_1)
                            .foregroundStyle(selectedTab == tab ? DesignSystemAsset.primary400.swiftUIColor : DesignSystemAsset.gray600.swiftUIColor)
                            .frame(width: width)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            RoundedRectangle(cornerRadius: 3)
                .fill(DesignSystemAsset.primary400.swiftUIColor)
                .frame(width: width, height: 2)
                .offset(x: CGFloat(Tab.allCases.firstIndex(of: selectedTab) ?? 0) * (width + itemSpacing))
                .animation(.easeOut, value: selectedTab)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignSystemAsset.gray950.swiftUIColor)
    }
}

#Preview {
    SegmentedPicker(selectedTab: .constant(.turingTest))
}
