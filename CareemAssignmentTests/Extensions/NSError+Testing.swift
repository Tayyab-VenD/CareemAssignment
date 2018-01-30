//
//  NSError+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

extension NSError {
    static var stub: NSError {
        return NSError(
            domain: "domain",
            code: 0,
            userInfo: nil
        )
    }
}
