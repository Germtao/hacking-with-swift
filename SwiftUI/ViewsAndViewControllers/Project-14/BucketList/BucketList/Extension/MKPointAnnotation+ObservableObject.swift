//
//  MKPointAnnotation+ObservableObject.swift
//  BucketList
//
//  Created by QDSG on 2020/9/28.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            title ?? "Unknown title"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            subtitle ?? "Unknown subtitle"
        }
        
        set {
            subtitle = newValue
        }
    }
}
