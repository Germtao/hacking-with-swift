//
//  Capital.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/2.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
