//
//  Videos+CoreDataProperties.swift
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

extension Videos {

    @NSManaged var wonderName: String?
    @NSManaged var wonderVideoURL: String?

}
