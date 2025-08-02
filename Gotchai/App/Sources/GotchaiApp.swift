import ComposableArchitecture
import SwiftUI

@main
struct GotchaiApp: App {
    let store = Store(initialState: AppFeature.State()) { AppFeature() }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
