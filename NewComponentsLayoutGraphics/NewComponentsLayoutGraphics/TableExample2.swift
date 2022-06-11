//
//  TableExample2.swift
//  NewComponentsLayoutGraphics
//
//  Created by Przemyslaw Szafulski on 11/06/2022.
//

import SwiftUI

struct TableExample2: View {
    var body: some View {
        Table {
            TableColumn("Name") { row in
                Text(row.name)
            }
            TableColumn("Value") { row in
                Text("\(row.value)")
            }
            TableColumn("Value x 2") { row in
                Text("\(row.value * 2)")
            }
            TableColumn("Value x 3") { row in
                Text("\(row.value * 3)")
            }
        } rows: {
            Group {
                TableRow(RowItem())
                TableRow(RowItem())
                TableRow(RowItem())
                TableRow(RowItem())
                TableRow(RowItem())
                TableRow(RowItem())
                TableRow(RowItem())
            }
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
            TableRow(RowItem())
        }
    }
}

struct RowItem: Identifiable {
    let id = UUID()
    let name = "Name \(Int.random(in: 0...100))"
    let value = Int.random(in: 0...50)
}
