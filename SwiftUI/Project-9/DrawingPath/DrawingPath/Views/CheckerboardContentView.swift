//
//  CheckerboardContentView.swift
//  DrawingPath
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct CheckerboardContentView: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = Int.random(in: 4...8)
                    self.columns = Int.random(in: 4...16)
                }
            }
    }
}

struct CheckerboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckerboardContentView()
    }
}
