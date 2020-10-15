//
//  CustomAlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                Image("example")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name: ")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuideView()
    }
}
