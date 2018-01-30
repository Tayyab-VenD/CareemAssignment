//
//  APIOperation.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

/// Represents an executable API operation.
protocol APIOperation {
    associatedtype Model : Decodable

    /// Prepares a raw web request, which a client can execute.
    func webRequest(with configuration: APIConfiguration) -> WebRequest

    /// Executes this API operation with provided client.
    func execute(with apiClient: APIClient, completion: @escaping (APIResult<Model>) -> Void)
}

extension APIOperation {

    /// Executes this API operation and decodes the JSON response into model struct.
    func execute(with apiClient: APIClient, completion: @escaping (APIResult<Model>) -> Void) {
        apiClient.execute(webRequest(with: apiClient.configuration)) { (response) in
            if let error = response.error {
                completion(.failure(error))
            } else {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Model.self, from: response.data!)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
