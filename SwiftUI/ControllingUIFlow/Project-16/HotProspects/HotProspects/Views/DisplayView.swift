//
//  DisplayView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
