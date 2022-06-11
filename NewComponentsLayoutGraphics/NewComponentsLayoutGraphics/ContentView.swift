// Copyright © 2022 xDesign. All rights reserved.

import SwiftUI

struct ContentView: View {
    @State var text = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    Group {
                        TextField("Multiline text field", text: $text, axis: .vertical)
                            .lineLimit(3)
                            .background(Color.blue.opacity(0.1))
                            .padding(.top, 8)
                        Divider()
                        ContentTableNav()
                        Divider()
                        ContentGradientView()
                        Divider()
                        ContentShadowView()
                        Divider()
                        ContentTextAnimationView()
                        Divider()
                    }
                    ContentTextCustomFontAnimationView()
                }
                .font(.title)
                .padding()
            }
        }
    }
}

struct ContentTableNav: View {
    var body: some View {
        NavigationLink("Tables - see on ipad") {
            TableExample()
        }
        NavigationLink("Tables 2 - see on ipad") {
            TableExample2()
        }
        NavigationLink("Grid") {
            GridExample()
        }
        NavigationLink("Transferable - NOT WORKING") {
            TransferableView()
        }
    }
}

struct ContentGradientView: View {
    var body: some View {
        Text("Default gradient")
        Circle()
            .fill(Color.blue.gradient)
            .frame(width: 200, height: 200)
        Text("Gradient with specific colors (Goes up to down by default)")
        Circle()
            .fill(AnyGradient(.init(colors: [Color.blue, Color.red, Color.yellow])))
            .frame(width: 200, height: 200)
        Text("Gradient with stops (0, 0.2, 0.5, 1) for (blue, red, green, yellow)")
        Circle()
            .fill(AnyGradient(.init(stops: [.init(color: Color.blue, location: 0),
                                            .init(color: Color.red, location: 0.2),
                                            .init(color: Color.green, location: 0.5),
                                            .init(color: Color.yellow, location: 1)])))
            .frame(width: 200, height: 200)
    }
}

struct ContentShadowView: View {
    var body: some View {
        Text("Shadow on SFSymbols")
        Text("Drop shadow")
        Image(systemName: "lasso.and.sparkles")
            .font(.system(size: 240))
            .frame(width: 400, height: 400)
            .background(in: Circle())
            .backgroundStyle(.blue.gradient)
            .foregroundStyle(.white.shadow(.drop(color: .black, radius: 15)))
        Text("Inner shadow")
        Image(systemName: "lasso.and.sparkles")
            .font(.system(size: 240))
            .frame(width: 400, height: 400)
            .background(in: Circle())
            .backgroundStyle(.blue.gradient)
            .foregroundStyle(.white.shadow(.inner(color: .black, radius: 15)))
    }
}

extension Font.Weight: CaseIterable {
    public static var allCases: [Font.Weight] {
        [.ultraLight, .light, .thin, .regular, .medium, .semibold, .bold, .black, .heavy]
    }
    
    var name: String {
        String(describing: self)
    }
}

extension Font.Design: CaseIterable {
    public static var allCases: [Font.Design] {
        [.default, .monospaced, .rounded, .serif]
    }
    
    var name: String {
        String(describing: self)
    }
}
struct ContentTextAnimationView: View {
    @State private var fontSize = 10.0
    @State private var fontWeight = Font.Weight.regular
    @State private var fontDesign = Font.Design.default
    
    @State private var textFontSize = 10.0
    @State private var textFontWeight = Font.Weight.regular
    @State private var textFontDesign = Font.Design.default
    var body: some View {
        Text("System font animation")
        Slider(value: $fontSize, in: 1...150)
        Menu("Font weight") {
            ForEach(Font.Weight.allCases, id: \.self) { weight in
                Button {
                    fontWeight = weight
                } label: {
                    Text("\(weight.name)")
                }
            }
        }
        Menu("Font design") {
            ForEach(Font.Design.allCases, id: \.self) { design in
                Button {
                    fontDesign = design
                } label: {
                    Text("\(design.name)")
                }
            }
        }
        Text("Current values: \(textFontSize) - \(textFontWeight.name) - \(textFontDesign.name)")
            .font(.system(size: 20, design: .monospaced))
        Text("New values:     \(fontSize) - \(fontWeight.name) - \(fontDesign.name)")
            .font(.system(size: 20, design: .monospaced))
        Button("Animate") {
            withAnimation {
                textFontSize = fontSize
                textFontDesign = fontDesign
                textFontWeight = fontWeight
            }
        }
        Text("Text that will animate")
            .font(.system(size: textFontSize, weight: textFontWeight, design: textFontDesign))
    }
}

struct ContentTextCustomFontAnimationView: View {
    let possibleFontNames = ["HelveticaNeue", "HelveticaNeue-Medium", "HelveticaNeue-Bold"]
    @State private var fontSize = 10.0
    @State private var fontName = "HelveticaNeue"
    
    @State private var textFontSize = 10.0
    @State private var textFontName = "HelveticaNeue"
    
    var body: some View {
        Text("HelveticaNeue font animation")
        Slider(value: $fontSize, in: 1...150)
        Menu("Font name") {
            ForEach(possibleFontNames, id: \.self) { newName in
                Button {
                    fontName = newName
                } label: {
                    Text("\(newName)")
                }
            }
        }
        Text("Current values: \(textFontSize) - \(textFontName)")
            .font(.system(size: 20, design: .monospaced))
        Text("New values:     \(fontSize) - \(fontName)")
            .font(.system(size: 20, design: .monospaced))
        Button("Animate") {
            withAnimation {
                textFontSize = fontSize
                textFontName = fontName
            }
        }
        Text("Text that will animate")
            .font(.custom(textFontName, size: textFontSize))
    }
}
