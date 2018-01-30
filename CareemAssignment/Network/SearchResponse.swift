//
//  SearchResponse.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

/*
{
  "page": 1,
  "results": [],
  "total_results": 14,
  "total_pages": 1
}
*/
struct SearchResponse : Codable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
