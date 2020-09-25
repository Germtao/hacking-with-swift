//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by QDSG on 2020/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
            
            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(Color.red)
            
            VStack(spacing: 10.0) {
                CapsuleText(text: "First")
                    .foregroundColor(Color.white)
                CapsuleText(text: "Second")
                    .foregroundColor(Color.yellow)
            }
            
            GridStack(rows: 4, columns: 4) { (row, col) in
                Image(systemName: "\(row * 4 + col).circle")
                Text("行\(row) 列\(col)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
