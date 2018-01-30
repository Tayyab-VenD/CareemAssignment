//
//  Movie+Testing.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

extension Movie {
    static var stub: Movie {
        return Movie(
            id: 1,
            overview: "overview",
            posterPath: "poster_path",
            releaseDate: Date(timeIntervalSince1970: 0),
            title: "title"
        )
    }
}

extension Movie: Equatable { }

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
