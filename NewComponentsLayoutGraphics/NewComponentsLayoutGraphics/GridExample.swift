// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct GridExample: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("First grid")
                Grid {
                    GridRow {
                        Text("Row 1")
                        ForEach(0 ..< 2) { _ in Color.red }
                    }
                    GridRow {
                        Text("Row 2")
                        ForEach(0 ..< 5) { _ in Color.green }
                    }
                    GridRow {
                        Text("Row 3")
                        ForEach(0 ..< 4) { _ in Color.blue }
                    }
                }
                Text("Second grid")
                Grid {
                    GridRow {
                        Rectangle().fill(.blue.gradient)
                        Rectangle().fill(.blue.gradient)
                            .gridCellColumns(2)
                        Rectangle().fill(.blue.gradient)
                    }
                    .frame(height: 100)
                    GridRow {
                        Rectangle().fill(.blue.gradient)
                            .gridCellColumns(2)
                        Rectangle().fill(.blue.gradient)
                        Rectangle().fill(.blue.gradient)
                    }
                    .frame(height: 100)
                }
                Text("Grid within Grid")
                Grid {
                    GridRow {
                        Rectangle().fill(.blue.gradient)
                        Grid {
                            GridRow {
                                Rectangle().fill(.blue.gradient)
                                    .gridCellColumns(2)
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                            }
                            GridRow {
                                Rectangle().fill(.blue.gradient)
                                    .gridCellColumns(2)
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                            }
                        }
                        Rectangle().fill(.blue.gradient)
                            .gridCellColumns(2)
                    }
                    .frame(height: 100)
                    GridRow {
                        Grid {
                            GridRow {
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                            }
                            GridRow {
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                            }
                            GridRow {
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                                Rectangle().fill(.blue.gradient)
                            }
                        }
                            .gridCellColumns(2)
                        Rectangle().fill(.blue.gradient)
                        Rectangle().fill(.blue.gradient)
                    }
                    .frame(height: 100)
                }
            }
        }
    }
}

struct GridExample_Previews: PreviewProvider {
    static var previews: some View {
        GridExample()
    }
}
