//
//  MottoView.swift
//  ViewsAndModifiers
//
//  Created by QDSG on 2020/9/21.
//

import SwiftUI

struct MottoView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        VStack {
            VStack {
                motto1
                    .foregroundColor(.red)
                motto2
                    .foregroundColor(.blue)
            }
        }
    }
}

struct MottoView_Previews: PreviewProvider {
    static var previews: some View {
        MottoView()
    }
}
