//
//  Movie+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String
    @NSManaged public var title: String
    @NSManaged public var year: Int16

}

extension Movie : Identifiable {

}
