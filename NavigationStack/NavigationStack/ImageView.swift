// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var navigation: Navigation
    
    let imageName: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.title)
            Button("Pop to home") {
                navigation.destination.removeAll()
            }
        }
        .navigationTitle("ImageView")
    }
}
