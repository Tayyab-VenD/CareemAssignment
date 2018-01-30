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

    var configuration = APIConfiguration.stub()
    var webResponse: WebResponse!
    var apiModel: Any!
    var apiError: Error!

    func execute(_ webRequest: WebRequest, completion: @escaping (WebResponse) -> Void) {
        completion(webResponse)
    }

    func execute<T>(_ apiRequest: T, completion: @escaping (APIResult<T.Model>) -> Void) where T : APIRequest {
        if let model = apiModel {
            completion(.success(model as! T.Model))
        } else {
            completion(.failure(apiError))
        }
    }
}
