//
//  WebRequest+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension WebRequest: Equatable { }

public func ==(lhs: WebRequest, rhs: WebRequest) -> Bool {
    let areEqual = (
        lhs.method == rhs.method &&
            lhs.url == rhs.url &&
            ((lhs.headers == nil && rhs.headers == nil) || (lhs.headers! == rhs.headers!)) &&
            lhs.body == rhs.body
    )

    return areEqual
}
