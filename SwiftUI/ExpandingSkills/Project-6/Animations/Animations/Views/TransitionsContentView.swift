//
//  TransitionsContentView.swift
//  Animations
//
//  Created by QDSG on 2020/9/21.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

struct TransitionsContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct TransitionsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionsContentView()
    }
}
