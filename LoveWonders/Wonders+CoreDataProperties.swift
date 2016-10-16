//
//  Wonders+CoreDataProperties.swift
//  LoveWonders
//
//  Created by Ivan Kurhanskyi on 9/25/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Wonders {

    @NSManaged var wonderType: String
    @NSManaged var wonderName: String
    @NSManaged var wonderNotes: String
    @NSManaged var wonderShow: NSNumber
    @NSManaged var wonderLatitude: NSNumber
    @NSManaged var wonderLongitude: NSNumber

}
