//
//  Title.swift
//  ViewsAndModifiers
//
//  Created by QDSG on 2020/9/21.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
