//
//  FlowerContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct FlowerContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct FlowerContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerContentView()
    }
}
