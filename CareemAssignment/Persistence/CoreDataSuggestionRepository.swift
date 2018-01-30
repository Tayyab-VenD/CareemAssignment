//
//  CoreDataSuggestionRepository.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import CoreData
import Foundation

class CoreDataSuggestionRepository : SuggestionRepository {

    private let stack: CoreDataStack

    init(_ stack: CoreDataStack) {
        self.stack = stack
    }

    func save(_ suggestion: Suggestion) {
        let request = NSFetchRequest<SuggestionEntity>(entityName: SuggestionEntity.className)
        request.predicate = NSPredicate(format:"\(#keyPath(SuggestionEntity.text)) = %@", suggestion.text)

        // Check if this suggestion already exists.
        var entity = (try? stack.viewContext.fetch(request))?.first
        if entity == nil {
            // Create a new entity if it does not.
            entity = NSEntityDescription.insertNewObject(forEntityName: SuggestionEntity.className, into: stack.viewContext) as? SuggestionEntity
        }

        // Populate the entity.
        entity!.text = suggestion.text
        entity!.createdAt = NSDate()

        do {
            try stack.viewContext.save()
        } catch { }
    }

    func fetchRecent(completion: @escaping (_ : [Suggestion]) -> Void) {
        let request = NSFetchRequest<SuggestionEntity>(entityName: SuggestionEntity.className)
        request.fetchLimit = 10
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SuggestionEntity.createdAt), ascending: false)]

        do {
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
