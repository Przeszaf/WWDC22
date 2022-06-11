//
//  NavigationStackApp.swift
//  NavigationStack
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

@main
struct NavigationStackApp: App {
    
    @StateObject var navigation = Navigation()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
        }
    }
}

class Navigation: ObservableObject {
    @Published var destination = [Destination]()
}
