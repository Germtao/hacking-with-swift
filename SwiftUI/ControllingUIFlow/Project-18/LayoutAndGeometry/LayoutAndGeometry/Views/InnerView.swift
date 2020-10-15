//
//  InnerView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture(count: 1, perform: {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    })
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct InnerView_Previews: PreviewProvider {
    static var previews: some View {
        InnerView()
    }
}
