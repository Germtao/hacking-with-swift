//
//  ContentView.swift
//  SnowSeeker
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationBarTitle("Primary")
            
            Text("Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
