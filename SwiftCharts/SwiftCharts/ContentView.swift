// Copyright © 2022 xDesign. All rights reserved.

import Charts
import SwiftUI

struct RandomData: Identifiable {
    let id = UUID()
    let x: Int
    let y: Int
}

struct ContentView: View {
    let data = getRandomData(count: 200)
    @State private var beforeDragPosition = 0
    @State private var position = 0

    var body: some View {
        VStack {
            Chart {
                ForEach(position...position+50, id: \.self) { i in
                    LineMark(
                        x: .value("X", data[i].x),
                        y: .value("Y", data[i].y)
                    )
                }
            }
            .chartOverlay(content: { proxy in
                GeometryReader { g in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let startX = value.startLocation.x - g[proxy.plotAreaFrame].origin.x
                                    let currentX = value.location.x - g[proxy.plotAreaFrame].origin.x
                                    if let startValue: Int = proxy.value(atX: startX),
                                       let currentValue: Int = proxy.value(atX: currentX) {
//                                        withAnimation {
                                            position = max(0, beforeDragPosition - currentValue + startValue)
//                                        }
                                        print(position)
                                    }
                                }
                                .onEnded { _ in
                                    beforeDragPosition = position
                                }
                        )
                }
            })
            .chartXScale(domain: 0 ... 50, type: .linear)
        }
    }
}

private func getRandomData(count: Int) -> [RandomData] {
    var randomData = [RandomData]()
    for i in 0 ..< count {
        randomData.append(.init(x: i, y: Int.random(in: 0 ... 10) + i))
    }
    return randomData
}
