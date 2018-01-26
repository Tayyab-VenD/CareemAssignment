//
//  StubPersistence.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

class StubPersistence : Persistence {

    var recentSuggestions: [Suggestion]!

    func saveSuggestion(_ suggestion: Suggestion) {
    }

    func fetchRecentSuggestions(completion: @escaping (_ : [Suggestion]) -> Void) {
        completion(recentSuggestions)
    }
}
