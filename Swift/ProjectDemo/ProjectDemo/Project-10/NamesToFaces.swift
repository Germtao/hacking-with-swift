//
//  NamesToFaces.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/1.
//

import Foundation

//class NamesToFaces: NSObject, NSCoding {
//    var name: String
//    var image: String
//
//    init(name: String, image: String) {
//        self.name = name
//        self.image = image
//    }
//
//    required init?(coder: NSCoder) {
//        name = coder.decodeObject(forKey: "name") as! String
//        image = coder.decodeObject(forKey: "image") as! String
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(name, forKey: "name")
//        coder.encode(image, forKey: "image")
//    }
//}

struct NamesToFaces: Codable {
    var name: String
    var image: String
}
