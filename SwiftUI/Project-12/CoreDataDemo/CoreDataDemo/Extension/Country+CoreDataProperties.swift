//
//  Country+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: Candy?

}

extension Country : Identifiable {

}
