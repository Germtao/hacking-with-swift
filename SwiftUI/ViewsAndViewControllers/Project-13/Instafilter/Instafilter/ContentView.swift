//
//  ContentView.swift
//  Instafilter
//
//  Created by QDSG on 2020/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        let blur = Binding<CGFloat> {
            self.blurAmount
        } set: {
            self.blurAmount = $0
            print("New value is \(blurAmount)")
        }
        
        return VStack {
            Text("Hello, world!")
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .blur(radius: blurAmount)
                .onTapGesture {
                    showingActionSheet = true
                }
                .actionSheet(isPresented: $showingActionSheet, content: {
                    ActionSheet(
                        title: Text("改变颜色"),
                        message: Text("选择一个新的颜色"),
                        buttons: [
                            .default(Text("红色"), action: {
                                backgroundColor = .red
                            }),
                            .default(Text("绿色"), action: {
                                backgroundColor = .green
                            }),
                            .default(Text("蓝色"), action: {
                                backgroundColor = .blue
                            }),
                            .cancel(Text("取消"))
                        ]
                    )
                })
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
