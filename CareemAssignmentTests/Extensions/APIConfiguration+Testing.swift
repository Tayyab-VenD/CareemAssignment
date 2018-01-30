//
//  APIConfiguration+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension APIConfiguration {
    static func stub() -> APIConfiguration {
        return APIConfiguration(
            baseURL: URL(string: "http://www.base.url/")!,
            imageURL: URL(string: "http://www.image.url/")!,
            apiKey: "api_key"
        )
    }
}
