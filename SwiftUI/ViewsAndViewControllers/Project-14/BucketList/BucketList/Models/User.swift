//
//  User.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
