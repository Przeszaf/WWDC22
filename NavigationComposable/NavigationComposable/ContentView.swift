// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigation: Navigation

    enum ContentViewRoutes {
        case child
    }

    var body: some View {
        NavigationStack(path: $navigation.path) {
            VStack {
                Text("ContentView")
                    .font(.title)
                Button("Go to Child") {
                    navigation.path.append(ContentViewRoutes.child)
                }
                Button("Go to Shared") {
                    navigation.path.append(GeneralRoute.shared("Shared"))
                }
            }
            .navigationDestination(for: ContentViewRoutes.self) { route in
                switch route {
                case .child:
                    ChildView()
                }
            }
            .navigationDestination(for: GeneralRoute.self) { route in
                switch route {
                case .shared(let text):
                    ChildTextView(text: text)
                }
            }
        }
    }
}

enum GeneralRoute: Hashable {
    case shared(String)
}

struct ChildView: View {
    @EnvironmentObject var navigation: Navigation

    enum ChildViewRoutes: Hashable {
        case text(String)
    }
    
    var body: some View {
        VStack {
            Text("ChildView")
                .font(.title)
            Button("Go to Child with text: TextChild1") {
                navigation.path.append(ChildViewRoutes.text("TextChild1"))
            }
        }
        .navigationDestination(for: ChildViewRoutes.self) { route in
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
            Button("Go to Shared") {
                navigation.path.append(GeneralRoute.shared("Shared 2"))
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
