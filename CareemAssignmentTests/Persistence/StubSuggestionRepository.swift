//
//  StubSuggestionRepository.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

class StubSuggestionRepository : SuggestionRepository {

    var recent: [Suggestion]!

    func save(_ suggestion: Suggestion) {
    }

    func fetchRecent(completion: @escaping (_ : [Suggestion]) -> Void) {
        completion(recent)
    }
}
