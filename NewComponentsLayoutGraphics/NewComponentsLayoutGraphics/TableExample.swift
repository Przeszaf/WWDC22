//
//  TableExample.swift
//  NewComponentsLayoutGraphics
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

private struct TableItem: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
    let secondValue: Int
}

private func createTableItems() -> [TableItem] {
    var items = [TableItem]()
    for i in 0...10 {
        items.append(.init(name: "Name \(i)",
                           value:Int.random(in: 0...40),
                           secondValue: Int.random(in: 0...100)))
    }
    return items
}

struct TableExample: View {
    @State private var tableItems = createTableItems()
    @State private var selection: TableItem.ID? = nil
    @State private var sortOder = [KeyPathComparator(\TableItem.name)]
    
    var body: some View {
        VStack {
            if let selection {
                Text("Selected: \(tableItems.first(where: {$0.id == selection})!.name)")
            } else {
                Text("Nothing selected")
            }
//            Menu("Sort order") {
//                Button {
//                    sortOder = [\TableItem.name]
//                } label: {
//                    Text("By name")
//                }
//
//            }
            Table(tableItems, selection: $selection, sortOrder: $sortOder) {
                TableColumn("Given Name", value: \.name)
                TableColumn("Value", value: \.value) {
                    Text("\($0.value)")
                }
                TableColumn("Second value", value: \.secondValue) {
                    Text("\($0.secondValue)")
                }
            }
        }
        .onChange(of: sortOder) { newValue in
            tableItems.sort(using: newValue)
        }
    }
}
