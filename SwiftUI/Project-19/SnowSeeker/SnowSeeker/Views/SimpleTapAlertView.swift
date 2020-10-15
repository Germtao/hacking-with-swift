//
//  SimpleTapAlertView.swift
//  SnowSeeker
//
//  Created by QDSG on 2020/10/15.
//

import SwiftUI

struct SimpleTapAlertView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingAlert = false
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
                self.isShowingAlert = true
            }
//            .alert(item: $selectedUser) { user in
//                Alert(title: Text(user.id))
//            }
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text(selectedUser!.id))
            })
    }
}

struct SimpleTapAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTapAlertView()
    }
}
