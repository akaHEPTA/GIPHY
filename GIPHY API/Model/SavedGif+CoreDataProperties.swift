//
//  SavedGif+CoreDataProperties.swift
//  
//
//  Created by Richard Cho on 2021-11-28.
//
//

import Foundation
import CoreData


extension SavedGif {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedGif> {
        return NSFetchRequest<SavedGif>(entityName: "SavedGif")
    }

    @NSManaged public var id: String?
    @NSManaged public var url: String?

}
