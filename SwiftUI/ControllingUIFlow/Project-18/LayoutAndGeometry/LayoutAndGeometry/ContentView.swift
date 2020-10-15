//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
//            .background(Color.red)
            .position(x: 100, y: 100) // 绝对位置
//            .offset(x: 100, y: 100) // 相对位置
            .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
