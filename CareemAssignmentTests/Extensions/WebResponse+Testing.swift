//
//  WebResponse+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension WebResponse {

    init(string: String) {
        self.init(data: string.data(using: .utf8), error: nil)
    }

    init(error: Error) {
        self.init(data: nil, error: error)
    }
}
