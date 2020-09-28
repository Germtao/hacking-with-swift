//
//  EditView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/28.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("地名", text: $placemark.wrappedTitle)
                    TextField("详细信息", text: $placemark.wrappedSubtitle)
                }
            }
            .navigationBarTitle("编辑地址")
            .navigationBarItems(trailing: Button("完成", action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
