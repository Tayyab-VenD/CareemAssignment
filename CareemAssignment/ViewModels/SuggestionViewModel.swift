//
//  SuggestionViewModel.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class SuggestionViewModel {

    private let model: Suggestion

    init(_ suggestion: Suggestion) {
        self.model = suggestion
    }

    var suggestion: String {
        return model.text
    }
}
