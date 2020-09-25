//
//  CapsuleText.swift
//  ViewsAndModifiers
//
//  Created by QDSG on 2020/9/21.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct CapsuleText_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleText(text: "Capsule Text")
    }
}
