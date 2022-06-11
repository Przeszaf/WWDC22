//
//  TextView.swift
//  NavigationStack
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

struct TextView: View {
    
    @EnvironmentObject var navigation: Navigation
    
    let text: String
    var body: some View {
        VStack {
            Text(text)
                .font(.title)
            Button {
                navigation.destination.append(.image("plus"))
            } label: {
                HStack {
                    Text("Go to ")
                    Image(systemName: "plus")
                }
            }
            Button {
                navigation.destination.append(.image("minus"))
            } label: {
                HStack {
                    Text("Go to ")
                    Image(systemName: "minus")
                }
            }
        }
        .navigationTitle("TextView")
    }
}
