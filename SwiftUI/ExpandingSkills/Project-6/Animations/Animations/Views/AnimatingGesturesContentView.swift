//
//  AnimatingGesturesContentView.swift
//  Animations
//
//  Created by QDSG on 2020/9/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

/// 动画手势
struct AnimatingGesturesContentView: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )
    }
}

struct AnimatingGesturesContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGesturesContentView()
    }
}
