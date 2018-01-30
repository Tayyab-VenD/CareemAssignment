//
//  APIClient.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

/// Represents web methods, such as GET, POST, PUT, DELETE.
enum WebMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Represents a raw web request.
struct WebRequest {
    var method: WebMethod
    var url: URL
    var headers: [String: String]?
    var body: Data?

    init(method: WebMethod,
         url: URL,
         headers: [String: String]? = nil,
         body: Data? = nil) {
        self.method = method
        self.url = url
        self.headers = headers
        self.body = body
    }
}

/// Represents a raw web response.
struct WebResponse {
    var data: Data?
    var error: Error?

    init(data: Data? = nil,
         error: Error? = nil) {
        self.data = data
        self.error = error
    }
}

/// Responsible for executing a web request.
protocol APIClient {
    var configuration: APIConfiguration { get }

    /// Executes a web request asynchronously, and provides its response in completion block.
    func execute(_ webRequest: WebRequest, completion: @escaping (_ webResponse: WebResponse) -> Void)
}
