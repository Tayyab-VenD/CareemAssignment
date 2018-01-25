//
//  Persistence.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 24/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

protocol Persistence {
    func saveSuggestion(_ suggestion: Suggestion)
    func fetchRecentSuggestions(completion: @escaping (_ : [Suggestion]) -> Void)
}
