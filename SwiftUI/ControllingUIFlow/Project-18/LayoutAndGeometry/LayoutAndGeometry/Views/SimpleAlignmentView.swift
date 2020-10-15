//
//  SimpleAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct SimpleAlignmentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
            Text("This is a longer line of text.")
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

struct SimpleAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAlignmentView()
    }
}
