//
//  SuggestionEntity+CoreDataProperties.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 24/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import CoreData
import Foundation

extension SuggestionEntity {
    @NSManaged public var text: String?
    @NSManaged public var createdAt: NSDate?
}
