//
//  Petitions.swift
//  WhitehousePetitions
//
//  Created by QDSG on 2020/9/1.
//

import Foundation

struct Petitions: Codable {
    var results: [Petition]
}

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
