//
//  MovieResultViewModel.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class MovieResultViewModel {

    private let movie: Movie

    init(_ movie: Movie) {
        self.movie = movie
    }

    var posterURL: String {
        return movie.posterPath
    }

    var title: String {
        return movie.title
    }

    var overview: String {
        return movie.overview
    }

    var releaseDate: String {
        return movie.releaseDate
    }
}
