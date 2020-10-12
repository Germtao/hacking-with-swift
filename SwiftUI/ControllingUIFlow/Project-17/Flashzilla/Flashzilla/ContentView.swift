//
//  ContentView.swift
//  Flashzilla
//
//  Created by QDSG on 2020/10/12.
//

import SwiftUI

struct ContentView: View {
    /// 圆已经拖了多远
    @State private var offset = CGSize.zero
    /// 当前是否被拖动
    @State private var isDragging = false
    
//    @State private var currentAmount: Angle = .degrees(0)
//    @State private var finalAmount: Angle = .degrees(1)
    
//    @State private var currentAmount: CGFloat = 0
//    @State private var finalAmount: CGFloat = 1
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
//        VStack {
//            Text("Hello, world!")
//                .onTapGesture(count: 1, perform: {
//                    print("Text Tapped!")
//                })
//        }
//        .simultaneousGesture( // 父手势和子手势同时触发
//            TapGesture()
//                .onEnded {
//                    print("VStack Tapped!")
//                }
//        )
        
//        .highPriorityGesture( // 强制优化父控件手势
//            TapGesture()
//                .onEnded {
//                    print("VStack Tapped!")
//                }
//        )
//        .onTapGesture(count: 1, perform: {
//            print("VStack Tapped!")
//        }) // 默认优先子控件手势
        
//        Text("Hello, world!")
//            .rotationEffect(finalAmount + currentAmount)
//            .gesture(
//                RotationGesture() // 旋转
//                    .onChanged({ angle in
//                        self.currentAmount = angle
//                    })
//                    .onEnded({ angle in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = .degrees(0)
//                    })
//            )
        
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture(
//                MagnificationGesture() // 放大手势
//                    .onChanged({ amount in
//                        self.currentAmount = amount - 1
//                    })
//                    .onEnded({ amount in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = 0
//                    })
//            )
        
//            .onTapGesture(count: 2, perform: {
//                print("Double tapped!")
//            })
//            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
//                print("In progress: \(inProgress)")
//            }) {
//                print("Long pressed!")
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
