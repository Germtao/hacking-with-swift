//
//  ContentView.swift
//  Flashzilla
//
//  Created by QDSG on 2020/10/12.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale: CGFloat = 1
    
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
        
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture(count: 1, perform: {
//                if self.reduceMotion {
//                    self.scale *= 1.5
//                } else {
//                    withAnimation {
//                        self.scale *= 1.5
//                    }
//                }
//                withOptionalAnimation {
//                    self.scale *= 1.5
//                }
//            })
        
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? Color.black : Color.green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
    }
}

extension ContentView {
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withOptionalAnimation(animation, body)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
