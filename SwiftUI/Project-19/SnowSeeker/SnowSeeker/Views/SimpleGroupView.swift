//
//  SimpleGroupView.swift
//  SnowSeeker
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct SimpleGroupContentView: View {
//    @State private var layoutVertically = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
//        Group {
//            if layoutVertically {
//                VStack {
//                    SimpleGroupView()
//                }
//            } else {
//                HStack {
//                    SimpleGroupView()
//                }
//            }
//        }
//        .onTapGesture {
//            self.layoutVertically.toggle()
//        }
        
        Group {
            if sizeClass == .compact {
//                VStack {
//                    SimpleGroupView()
//                }
                VStack(content: SimpleGroupView.init)
            } else {
//                HStack {
//                    SimpleGroupView()
//                }
                HStack(content: SimpleGroupView.init)
            }
        }
    }
}

struct SimpleGroupView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct SimpleGroupContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleGroupContentView()
    }
}
