//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by QDSG on 2020/10/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("富强、民主、和谐")
//            .frame(width: 300, height: 300, alignment: .topLeading)
        
//        HStack(alignment: .lastTextBaseline/*.bottom*/) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
//        VStack(alignment: .leading) {
//            Text("Hello, World!")
//            Text("This is a longer line of text.")
//        }
//        .background(Color.red)
//        .frame(width: 400, height: 400)
//        .background(Color.blue)
        
//        VStack(alignment: .leading) {
//            Text("Hello, World!")
//                .alignmentGuide(.leading, computeValue: { dimension in
////                    dimension[.leading]
//                    dimension[.trailing]
//                })
//            Text("This is a longer line of text.")
//        }
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
