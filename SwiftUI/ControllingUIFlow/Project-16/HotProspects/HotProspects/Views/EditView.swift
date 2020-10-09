//
//  EditView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
