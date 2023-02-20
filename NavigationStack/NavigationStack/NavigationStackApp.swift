//
//  NavigationStackApp.swift
//  NavigationStack
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

@main
struct NavigationStackApp: App {
    
    @StateObject var navigation = Navigation.shared
    
    init() {
        Class()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
        }
    }
}

class Class {
    init() {
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            Navigation.shared.destination.append(.text("123123"))
        }
    }
}

class Navigation: ObservableObject {
    
    static let shared = Navigation()
    
    @Published var destination = [Destination]()
}
