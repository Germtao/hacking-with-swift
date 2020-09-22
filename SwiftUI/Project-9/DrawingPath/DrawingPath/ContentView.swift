//
//  ContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct ContentView: View {
    
    let datas = ["Triangle", "Trapezoid", "Arc", "Spirograph", "Checkerboard", "Flower", "ColorCycling"]
    
    var body: some View {
        NavigationView {
            List(0..<datas.count) {
                let title = datas[$0]
                switch $0 {
                case 0:
                    NavigationLink(title, destination: TriangleContentView())
                case 1:
                    NavigationLink(title, destination: TrapezoidContentView())
                case 2:
                    NavigationLink(title, destination: ArcContentView())
                case 3:
                    NavigationLink(title, destination: SpirographContentView())
                case 4:
                    NavigationLink(title, destination: CheckerboardContentView())
                case 5:
                    NavigationLink(title, destination: FlowerContentView())
                default:
                    NavigationLink(title, destination: ColorCyclingContentView())
                }
            }
            .navigationTitle("Drawing Path")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
