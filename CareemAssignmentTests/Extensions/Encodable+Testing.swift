//
//  Encodable+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension Encodable {
    var jsonWebResponse: WebResponse {
        return WebResponse(data: try? JSONEncoder().encode(self))
    }
}
