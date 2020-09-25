//
//  ArcContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct ArcContentView: View {
    var body: some View {
        VStack {
            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(Color.blue, lineWidth: 40)
//                .frame
            
            InsettableArc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
        }
    }
}

struct ArcContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArcContentView()
    }
}
