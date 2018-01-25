//
//  CoreDataStack.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 24/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import CoreData
import Foundation

class CoreDataStack {

    let name: String

    init(name: String) {
        self.name = name
    }

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: name, withExtension: "momd")
        return NSManagedObjectModel(contentsOf: modelURL!)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        do {
            let supportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            if !FileManager.default.fileExists(atPath: supportURL.path, isDirectory: nil) {
                try FileManager.default.createDirectory(at: supportURL, withIntermediateDirectories: true, attributes: nil)
            }

            let storeURL = supportURL.appendingPathComponent("\(name).sqlite")
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            return coordinator
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }()

    lazy var viewContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

    func newBackgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = newBackgroundContext()
        context.perform {
            block(context)
        }
    }
}
