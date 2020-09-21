//
//  Watermark.swift
//  ViewsAndModifiers
//
//  Created by QDSG on 2020/9/21.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing, content: {
            content
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        })
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
