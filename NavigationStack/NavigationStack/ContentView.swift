// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        NavigationStack(path: $navigation.destination) {
            Button("Go to simple") {
                navigation.destination.append(.first)
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .first: FirstView()
                case let .text(string): TextView(text: string)
                case let .image(systemName): ImageView(imageName: systemName)
                }
            }
        }
    }
}
