//
//  ExplicitAnimationContentView.swift
//  Animations
//
//  Created by QDSG on 2020/9/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

/// 显示动画
struct ExplicitAnimationContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("显示动画") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

struct ExplicitAnimationContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimationContentView()
    }
}
