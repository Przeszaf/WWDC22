// Copyright © 2022 xDesign. All rights reserved.

import PhotosUI
import SwiftUI


// NOT WORKING ON SIMULATOR YET

struct ContentView: View {
    @State var selection: PhotosPickerItem? = nil {
        didSet {
            print(selection)
        }
    }

    var body: some View {
        PhotosPicker(selection: $selection, matching: .images) {
            Text("Select photo!")
        }
    }
}
