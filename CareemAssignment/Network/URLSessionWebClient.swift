//
//  URLSessionWebClient.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class URLSessionWebClient : WebClient {

    let session: URLSession

    init(_ session: URLSession) {
        self.session = session
    }

    func execute(request: WebRequest, completion: @escaping (_ response: WebResponse) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                completion(WebResponse(data: data, error: error))
            }
        }.resume()
    }
}
