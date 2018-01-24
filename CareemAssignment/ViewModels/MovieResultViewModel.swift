//
//  MovieResultViewModel.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class MovieResultViewModel {

    private let service: MovieDBService
    private let movie: Movie

    init(service: MovieDBService, movie: Movie) {
        self.service = service
        self.movie = movie
    }

    var posterURL: URL? {
        if let path = movie.posterPath {
            return service.posterURL(from: path, with: .w185)
        }

        return nil
    }

    var title: String {
        return movie.title
    }

    var overview: String {
        return movie.overview ?? ""
    }

    var releaseDate: String {
        if let releaseDate = movie.releaseDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")

            return formatter.string(from: releaseDate)
        }

        return ""
    }
}
