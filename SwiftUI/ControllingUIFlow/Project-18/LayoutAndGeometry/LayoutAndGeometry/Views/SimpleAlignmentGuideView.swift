//
//  SimpleAlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct SimpleAlignmentGuideView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number: \(position)")
                    .alignmentGuide(.leading, computeValue: { dimension in
                        CGFloat(position) * -10
                    })
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

struct SimpleAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAlignmentGuideView()
    }
}
