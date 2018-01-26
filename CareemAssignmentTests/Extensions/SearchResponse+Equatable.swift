//
//  SearchResponse+Equatable.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension SearchResponse: Equatable {

}

public func ==(lhs: SearchResponse, rhs: SearchResponse) -> Bool {
    let areEqual = (
        lhs.page == rhs.page &&
        lhs.results == rhs.results &&
        lhs.totalResults == rhs.totalResults &&
        lhs.totalPages == rhs.totalPages
    )

    return areEqual
}
