//
//  ContentView.swift
//  Animations
//
//  Created by QDSG on 2020/6/30.
//  Copyright © 2020 tTao. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            AnimatedBindingsContentView()
            
            ExplicitAnimationContentView()
            
            ControllingTheAnimationStackContentView()
            
            AnimatingGesturesContentView()
            
            SnakeLettersContentView()
            
            TransitionsContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
