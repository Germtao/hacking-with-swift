//
//  AnimatedBindingsContentView.swift
//  Animations
//
//  Created by QDSG on 2020/9/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

struct AnimatedBindingsContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Stepper(
                "Scale amount",
                value:$animationAmount.animation(
                    Animation
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                ),
                in: 1...10
            )
            
            Spacer()
            
            /// 隐式动画
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct AnimatedBindingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBindingsContentView()
    }
}
