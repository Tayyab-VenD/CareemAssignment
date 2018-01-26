//
//  Suggestion+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension Suggestion {
    static func stub() -> Suggestion {
        return Suggestion(text: "text")
    }
}

extension Suggestion: Equatable { }

public func ==(lhs: Suggestion, rhs: Suggestion) -> Bool {
    return lhs.text == rhs.text
}
