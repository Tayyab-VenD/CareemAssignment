//
//  Suggestion+Equatable.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension Suggestion: Equatable {

}

public func ==(lhs: Suggestion, rhs: Suggestion) -> Bool {
    return lhs.text == rhs.text
}
