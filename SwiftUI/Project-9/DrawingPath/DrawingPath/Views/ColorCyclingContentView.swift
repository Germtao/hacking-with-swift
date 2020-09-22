//
//  ColorCyclingContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
//                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                self.color(for: value, brightness: 1),
                                self.color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        // 为了弄清楚特定圆圈的色相，
        // 我们可以取圆圈数（例如25），除以圆圈数（例如100）
        // 然后加上颜色循环量（例如0.5）
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        // hue 是从0到1的值，控制着我们所看到的颜色的种类——红色是0到1，所有其他色相都介于两者之间
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .drawingGroup()
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ColorCyclingContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingContentView()
    }
}
