// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigation: Navigation

    enum Routes {
        case child
    }

    var body: some View {
        NavigationStack(path: $navigation.path) {
            VStack {
                Text("ContentView")
                    .font(.title)
                Button("Go to Child") {
                    navigation.path.append(Routes.child)
                }
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .child:
                    ChildView()
                }
            }
        }
    }
}

struct ChildView: View {
    @EnvironmentObject var navigation: Navigation

    enum Routes: Hashable {
        case text(String)
    }
    
    var body: some View {
        VStack {
            Text("ChildView")
                .font(.title)
            Button("Go to Child with text: TextChild1") {
                navigation.path.append(Routes.text("TextChild1"))
            }
        }
        .navigationDestination(for: Routes.self) { route in
            switch route {
            case .text(let string):
                ChildTextView(text: string)
            }
        }
    }
}

struct ChildTextView: View {
    @EnvironmentObject var navigation: Navigation
    let text: String
    
    enum Routes: Hashable {
        case image(String)
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.title)
            Button {
                navigation.path.append(Routes.image("plus"))
            } label: {
                HStack {
                    Text("Go to child with image")
                    Image(systemName: "plus")
                }
            }
            Button {
                navigation.path.append(Routes.image("minus"))
            } label: {
                HStack {
                    Text("Go to child with image")
                    Image(systemName: "minus")
                }
            }
        }
        .navigationDestination(for: Routes.self) { route in
            switch route {
            case .image(let string):
                ChildImageView(imageName: string)
            }
        }
    }
}

struct ChildImageView: View {
    @EnvironmentObject var navigation: Navigation
    let imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.title)
            Button("Pop to home") {
                navigation.path.removeLast(navigation.path.count)
            }
        }
    }
}

class Navigation: ObservableObject {
    @Published var path = NavigationPath()
}
