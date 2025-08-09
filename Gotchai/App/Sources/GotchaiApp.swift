import ComposableArchitecture
import SwiftUI

@main
struct GotchaiApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: StoreOf<AppFeature>(initialState: AppFeature.State(), reducer: {
                    AppFeature()
                }, withDependencies: { dep in

                })
            )
        }
    }
}

