// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

@main
struct NavigationComposableApp: App {
    @StateObject var navigation = Navigation()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(navigation)
            ComposableView(store: .init(initialState: .live(state: .init()), reducer: composableReducer,
                                        environment: ComposableEnvironment()))
        }
    }
}
