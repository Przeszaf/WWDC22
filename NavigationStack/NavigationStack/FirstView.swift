//
//  SimpleView.swift
//  NavigationStack
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

struct FirstView: View {
    
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        VStack {
            Button("Text 1") {
                navigation.destination.append(.text("Text 1"))
            }
            Button("Text 2") {
                navigation.destination.append(.text("Text 2"))
            }
        }
        .navigationTitle("FirstView")
    }
}
