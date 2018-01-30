//
//  StubAPIClient.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

class StubAPIClient: APIClient {

    var configuration = APIConfiguration.stub
    var webResponse: WebResponse!

    func execute(_ webRequest: WebRequest, completion: @escaping (WebResponse) -> Void) {
        completion(webResponse)
    }
}
