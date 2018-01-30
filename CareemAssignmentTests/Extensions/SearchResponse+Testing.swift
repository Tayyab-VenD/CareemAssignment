//
//  SearchResponse+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension SearchResponse {
    static func stub(results: Int = 0) -> SearchResponse {
        let results = Array<Movie>(repeating: Movie.stub, count: results)

        return SearchResponse(
            page: 1,
            results: results,
            totalResults: 1,
            totalPages: 1
        )
    }
}

extension SearchResponse: Equatable { }

public func ==(lhs: SearchResponse, rhs: SearchResponse) -> Bool {
    let areEqual = (
        lhs.page == rhs.page &&
        lhs.results == rhs.results &&
        lhs.totalResults == rhs.totalResults &&
        lhs.totalPages == rhs.totalPages
    )

    return areEqual
}
