//
//  ControllingTheAnimationStackContentView.swift
//  Animations
//
//  Created by QDSG on 2020/9/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

struct ControllingTheAnimationStackContentView: View {
    @State private var enabled = false
    
    var body: some View {
        Button("控制动画堆栈") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(nil)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct ControllingTheAnimationStackContentView_Previews: PreviewProvider {
    static var previews: some View {
        ControllingTheAnimationStackContentView()
    }
}
