//
//  SuggestionRepository.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

protocol SuggestionRepository {
    func save(_ suggestion: Suggestion)
    func fetchRecent(completion: @escaping (_ : [Suggestion]) -> Void)
}
