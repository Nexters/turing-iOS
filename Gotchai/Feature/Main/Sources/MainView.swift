//
//  MainView.swift
//  Main
//
//  Created by 가은 on 7/27/25.
//

import TCA
import DesignSystem
import SwiftUI
import Profile

public struct MainView: View {
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("logo_mini", bundle: .module)
                Spacer()
                Button {
                    store.send(.tappedSettingButton)
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
                                .padding(.horizontal, 24)
                        }
                    case .achievement:
                        ProfileView()
                        Spacer()
                    }
                }
            }
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.gray_950))
    }
    
    @ViewBuilder
    private func TestCardList() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("icon_ab", bundle: .module)
            Text("테스트")
                .fontStyle(.body_2)
                .foregroundStyle(Color(.gray_white))
                .padding(.top, 12)
            Text("\(store.turingTestItems.count)개의 새로운 테스트가 있어요")
                .fontStyle(.body_4)
                .foregroundStyle(Color(.gray_400))
                .padding(.top, 2)
            
            ForEach(store.turingTestItems, id: \.id) { item in
                Button {
                    store.send(.tappedTestCard(item.id))
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
                .fill(Color(.gray_900))
        )
        .padding(.top, 16)
        .padding(.bottom, 40)
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
                Circle().fill(Color(.gray_900))
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .fontStyle(.body_2)
                    .foregroundStyle(Color(.gray_white))
                Text(item.subtitle)
                    .fontStyle(.body_4)
                    .foregroundStyle(Color(.gray_400))
            }
            Spacer()
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.gray_800))
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
