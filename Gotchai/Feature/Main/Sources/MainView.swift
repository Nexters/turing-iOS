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
        VStack(spacing: 0) {
            HStack {
                Image("logo_mini", bundle: .module)
                Spacer()
                Button {
                    store.send(.settingButtonTapped)
                } label: {
                    Image("icon_setting", bundle: .module)
                }
            }
            .padding(EdgeInsets(top: 9, leading: 22, bottom: 9, trailing: 24))
            
            WithViewStore(store, observe: \.selectedTab) { viewStore in
                let tab = viewStore.state
                VStack(spacing: 0) {
                    SegmentedPicker(selectedTab: viewStore.binding(
                        get: { $0 },
                        send: MainFeature.Action.selectedTabChanged
                    ))
                    
                    switch tab {
                    case .turingTest:
                        ScrollView {
                            TestCardList()
                        }
                    case .achievement:
                        // TODO: 업적(Profile) 연결
                        EmptyView()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DesignSystemAsset.gray950.swiftUIColor)
    }
    
    @ViewBuilder
    private func TestCardList() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("icon_ab", bundle: .module)
            Text("테스트")
                .font(.body_2)
                .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
                .padding(.top, 12)
            Text("\(store.turingTestItems.count)개의 새로운 테스트가 있어요")
                .font(.body_4)
                .foregroundStyle(DesignSystemAsset.gray400.swiftUIColor)
                .padding(.top, 2)
            
            ForEach(store.turingTestItems, id: \.id) { item in
                Button {
                    store.send(.testCardTapped(item.id))
                } label: {
                    TestCardItem(item: item)
                }
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DesignSystemAsset.gray900.swiftUIColor)
        )
        .padding(.top, 16)
    }
    
    @ViewBuilder
    private func TestCardItem(item: TuringTestCard) -> some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                image.resizable()
            } placeholder: {
//                ProgressView()
            }
            .frame(width: 80, height: 80)
            .background(
                Circle().fill(DesignSystemAsset.gray900.swiftUIColor)
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body_2)
                    .foregroundStyle(DesignSystemAsset.grayWhite.swiftUIColor)
                Text(item.subtitle)
                    .font(.body_4)
                    .foregroundStyle(DesignSystemAsset.gray400.swiftUIColor)
            }
            Spacer()
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DesignSystemAsset.gray800.swiftUIColor)
        )
    }
}

#Preview {
    MainView(
        store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        })
    )
}
