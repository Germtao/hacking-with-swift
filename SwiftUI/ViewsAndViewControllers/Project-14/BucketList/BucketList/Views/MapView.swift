//
//  MapView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<MapView>
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
