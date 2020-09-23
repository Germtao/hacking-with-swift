//
//  Candy+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
}

extension Candy : Identifiable {

}
