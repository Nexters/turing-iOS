//
//  MainView.swift
//  Main
//
//  Created by 가은 on 7/27/25.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        ZStack {
            DesignSystemAsset.gray950.swiftUIColor.ignoresSafeArea()
            VStack {
                HStack {
                    Image("logo_mini", bundle: .module)
                    Spacer()
                    Image("icon_setting", bundle: .module)
                }
                .padding(EdgeInsets(top: 9, leading: 22, bottom: 9, trailing: 24))
                
                WithViewStore(store, observe: \.selectedTab) { viewStore in
                    SegmentedPicker(selectedTab: viewStore.binding(
                        get: { $0 },
                        send: MainFeature.Action.selectedTabChanged
                    ))
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                
            }
        }
    }
}

#Preview {
    MainView(
        store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        })
    )
}
