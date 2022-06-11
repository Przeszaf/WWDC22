// Copyright © 2022 xDesign. All rights reserved.

import Foundation
import SwiftUI
//
// struct TransferItem: Transferable, Identifiable, Codable, Equatable {
//    let id: UUID
//    let name: String
//
//    init(id: UUID, name: String) {
//        self.id = id
//        self.name = name
//    }
//
//    init() {
//        self.init(id: UUID(), name: "\(Int.random(in: 1...100000))")
//    }
//
//    static var transferRepresentation: some TransferRepresentation {
//        CodableRepresentation(contentType: .plainText)
//    }
// }

private func getTransferItems() -> [String] {
    var items = [String]()
    for _ in 0 ... 10 {
        items.append("\(Int.random(in: 0 ... 100_000))")
    }
    return items
}

// NOT SURE WHY NOT WORKING
// https://developer.apple.com/forums/thread/707852
struct TransferableView: View {
    @State private var transferredItems = [String]()
    let allItems = getTransferItems()

    var body: some View {
        HStack {
            VStack {
                Text("All items")
                List(allItems, id: \.self, rowContent: { item in
                    Text("\(item)")
                        .draggable(item)
                })
            }
            .frame(maxWidth: .infinity)
            VStack {
                Text("Transferred items")
                List(transferredItems, id: \.self) { item in
                    Text("\(item)")
                }
                Text("DROP HERE")
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background { RoundedRectangle(cornerRadius: 10).fill(Color.blue.gradient.opacity(0.2)) }
                    .dropDestination(payloadType: String.self) { items, location in
                        if transferredItems.contains(items) {
                            return false
                        } else {
                            transferredItems.append(contentsOf: items)
                            return true
                        }
                    }
            }
            .frame(maxHeight: .infinity)
        }
    }
}
