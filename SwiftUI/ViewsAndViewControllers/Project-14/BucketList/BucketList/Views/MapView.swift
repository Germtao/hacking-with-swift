//
//  MapView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    var annotations: [MKPointAnnotation]
    
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    typealias Context = UIViewRepresentableContext<MapView>
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                // 将信息按钮附加到视图
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else { return }
            
            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                annotations: [MKPointAnnotation.example],
                selectedPlace: .constant(MKPointAnnotation.example),
                showingPlaceDetails: .constant(false))
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "杭州"
        annotation.subtitle = "浙江省会城市"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 30.16, longitude: 120.12)
        return annotation
    }
}
