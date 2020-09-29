//
//  SliderContentView.swift
//  Accessibility
//
//  Created by QDSG on 2020/9/29.
//

import SwiftUI

struct SliderContentView: View {
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        VStack {
            Slider(value: $estimate, in: 0...50)
                .accessibility(value: Text("\(Int(estimate))"))
                .padding()
            
            Stepper("评价: \(rating)/5", value: $rating, in: 1...5)
                .accessibility(value: Text("\(rating) 满分5分"))
        }
    }
}

struct SliderContentView_Previews: PreviewProvider {
    static var previews: some View {
        SliderContentView()
    }
}
