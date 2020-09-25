//
//  TriangleContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct TriangleContentView: View {
    var body: some View {
        Triangle()
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
    }
}

struct TriangleContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleContentView()
    }
}
