//
//  Movie+Equatable.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension Movie: Equatable {

}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
    let areEqual = (
        lhs.id == rhs.id &&
        lhs.overview == rhs.overview &&
        lhs.posterPath == rhs.posterPath &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.title == rhs.title
    )

    return areEqual
}
