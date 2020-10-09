//
//  ContentView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import SwiftUI

struct ContentView: View {
    let user = User()
    
    var body: some View {
        VStack {
//            EditView().environmentObject(user)
//            DisplayView().environmentObject(user)
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
