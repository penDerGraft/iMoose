//
//  Animal.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/23/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import Foundation
import CoreData

class Animal: NSManagedObject {

    @NSManaged var color: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var species: String
    @NSManaged var weight: NSNumber
    @NSManaged var photo: NSData
}
