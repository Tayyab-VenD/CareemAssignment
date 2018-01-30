//
//  APIClient.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

enum WebMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

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

struct WebResponse {
    var data: Data? = nil
    var error: Error? = nil
}

protocol APIRequest {
    associatedtype Model : Decodable

    func webRequest(with configuration: APIConfiguration) -> WebRequest
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol APIClient {
    var configuration: APIConfiguration { get }

    func execute(_ webRequest: WebRequest, completion: @escaping (_ webResponse: WebResponse) -> Void)
    func execute<T>(_ apiRequest: T, completion: @escaping (APIResult<T.Model>) -> Void) where T : APIRequest
}
