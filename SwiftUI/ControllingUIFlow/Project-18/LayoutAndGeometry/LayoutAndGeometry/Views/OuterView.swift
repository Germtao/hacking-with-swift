//
//  OuterView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct OuterView_Previews: PreviewProvider {
    static var previews: some View {
        OuterView()
    }
}
