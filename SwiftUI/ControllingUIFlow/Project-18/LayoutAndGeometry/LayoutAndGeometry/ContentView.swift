//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                Text("Hello, World!")
//                    .frame(width: geo.size.width * 0.9, height: 40)
//                    .background(Color.red)
//            }
//            .background(Color.green)
//
//            Text("More Text")
//                .background(Color.blue)
//        }
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
