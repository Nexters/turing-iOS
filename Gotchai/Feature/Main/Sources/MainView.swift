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
            VStack(spacing: 0) {
                HStack {
                    Image("logo_mini", bundle: .module)
                    Spacer()
                    Image("icon_setting", bundle: .module)
                }
                .padding(EdgeInsets(top: 9, leading: 22, bottom: 9, trailing: 24))
                
                WithViewStore(store, observe: \.selectedTab) { viewStore in
                    let tab = viewStore.state
                    VStack(spacing: 0) {
                        SegmentedPicker(selectedTab: viewStore.binding(
                            get: { $0 },
                            send: MainFeature.Action.selectedTabChanged
                        ))
                        
                        Group {
                            switch tab {
                            case .turingTest:
                                ScrollView {
                                    testCardList()
                                }
                            case .achievement:
                                // TODO: 업적(Profile) 연결
                                EmptyView()
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func testCardList() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("icon_ab", bundle: .module)
            Text("테스트")
                .font(.body_2)
                .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
                .padding(.top, 12)
            Text("13개의 새로운 테스트가 있어요")
                .font(.body_4)
                .foregroundStyle(DesignSystemAsset.gray400.swiftUIColor)
                .padding(.top, 2)
            
            
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DesignSystemAsset.gray900.swiftUIColor)
        )
        .padding(.top, 16)
    }
}

#Preview {
    MainView(
        store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        })
    )
}
