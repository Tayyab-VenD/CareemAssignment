//
//  InMemoryCoreDataStack.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import CoreData
import Foundation

@testable import CareemAssignment

class InMemoryCoreDataStack: CoreDataStack {

    override lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        do {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            return coordinator
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }()
}
