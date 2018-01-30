//
//  SearchRequest.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

struct SearchRequest {
    let query: String
    let page: Int
}

extension SearchRequest : APIOperation {
    typealias Model = SearchResponse

    static var endpoint: String {
        return "/search/movie"
    }

    func webRequest(with configuration: APIConfiguration) -> WebRequest {
        return WebRequest(
            method: .get,
            url: URL(
                base: configuration.baseURL,
                path: SearchRequest.endpoint,
                parameters: [
                    "api_key": configuration.apiKey,
                    "query": query,
                    "page": page.description
                ]
            )!
        )
    }
}
