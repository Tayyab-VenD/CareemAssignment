//
//  URLSessionAPIClient.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class URLSessionAPIClient : APIClient {

    let configuration: APIConfiguration
    let session: URLSession
    let decoder: JSONDecoder

    init(_ configuration: APIConfiguration, session: URLSession) {
        self.configuration = configuration
        self.session = session
        self.decoder = JSONDecoder()
    }

    func execute(_ webRequest: WebRequest, completion: @escaping (_ webResponse: WebResponse) -> Void) {
        var urlRequest = URLRequest(url: webRequest.url)
        urlRequest.httpMethod = webRequest.method.rawValue
        urlRequest.allHTTPHeaderFields = webRequest.headers
        urlRequest.httpBody = webRequest.body

        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                completion(WebResponse(data: data, error: error))
            }
        }.resume()
    }

    func execute<T>(_ apiRequest: T, completion: @escaping (APIResult<T.Model>) -> Void) where T : APIRequest {
        execute(apiRequest.webRequest(with: configuration)) { (response) in
            if let error = response.error {
                completion(.failure(error))
            } else {
                do {
                    let result = try self.decoder.decode(T.Model.self, from: response.data!)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
