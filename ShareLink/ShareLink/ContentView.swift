//
//  ContentView.swift
//  ShareLink
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!) {
                Label("Share URL", systemImage: "plus")
            }
            ShareLink(item: "https://developer.apple.com/xcode/swiftui/") {
                Label("Share String", systemImage: "plus")
            }
        }
    }
}
