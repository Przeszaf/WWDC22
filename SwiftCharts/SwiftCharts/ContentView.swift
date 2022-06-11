// Copyright © 2022 xDesign. All rights reserved.

import Charts
import SwiftUI

struct RandomData: Identifiable {
    let id = UUID()
    let x: Date
    let y: Int
}

struct ContentView: View {
    let data = getRandomData(count: 200)
    @State private var beforeDragPosition = 0
    @State private var position = 0

    var body: some View {
        VStack {
            Chart {
                ForEach(position ..< position + 50, id: \.self) { i in
                    LineMark(
                        x: .value("Date", data[i].x),
                        y: .value("Y", data[i].y)
                    )
                }
            }
            .padding()
            .chartOverlay(content: { proxy in
                GeometryReader { g in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let startX = value.startLocation.x - g[proxy.plotAreaFrame].origin.x
                                    let currentX = value.location.x - g[proxy.plotAreaFrame].origin.x
                                    if let startValue: Date = proxy.value(atX: startX),
                                       let currentValue: Date = proxy.value(atX: currentX) {
                                        let newPosition = beforeDragPosition -
                                            Int(currentValue.timeIntervalSince1970) /
                                            86400 + Int(startValue.timeIntervalSince1970) / 86400
                                        position = min(data.count - 50, max(0, newPosition))
                                    }
                                }
                                .onEnded { _ in
                                    beforeDragPosition = position
                                }
                        )
                }
            })
            .chartXAxis(content: {
                AxisMarks(values: .automatic(desiredCount: 6))
            })
            .chartYAxis(content: {
                AxisMarks(values: .automatic(roundUpperBound: false))
            })
            .chartXScale(type: .date)
            .chartYScale(domain: data.min(by: { $0.y < $1.y })!.y ... data.max(by: { $0.y < $1.y })!.y)
        }
    }
}

private func getRandomData(count: Int) -> [RandomData] {
    var randomData = [RandomData]()
    for i in 0 ..< count {
        randomData.append(.init(x: .now.addingTimeInterval(86400.0 * Double(i)), y: Int.random(in: 0 ... 10) + i))
    }
    return randomData
}
