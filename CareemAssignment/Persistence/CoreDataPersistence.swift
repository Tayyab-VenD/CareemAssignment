//
//  SuggestionRepository.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 24/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import CoreData
import Foundation

class CoreDataPersistence : Persistence {

    private let stack: CoreDataStack

    init(_ stack: CoreDataStack) {
        self.stack = stack
    }

    func saveSuggestion(_ suggestion: Suggestion) {
        stack.performBackgroundTask { (context) in
            do {
                let entity = NSEntityDescription.insertNewObject(
                    forEntityName: SuggestionEntity.className,
                    into: context
                ) as! SuggestionEntity

                entity.text = suggestion.text
                entity.createdAt = Date() as NSDate

                try context.save()
            } catch {
            }
        }
    }

    func fetchRecentSuggestions(completion: @escaping (_ : [Suggestion]) -> Void) {
        do {
            let request = NSFetchRequest<SuggestionEntity>(entityName: SuggestionEntity.className)
            request.fetchLimit = 10
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SuggestionEntity.createdAt), ascending: false)]

            let entities = try stack.viewContext.fetch(request)
            let suggestions = entities.map({ (entity) -> Suggestion in
                Suggestion(text: entity.text!)
            })

            completion(suggestions)
        } catch {
            completion([])
        }
    }
}
