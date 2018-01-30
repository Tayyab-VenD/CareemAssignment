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
    private let imageManager: ImageManager

    init(_ movie: Movie, imageManager: ImageManager) {
        self.movie = movie
        self.imageManager = imageManager
    }

    var posterURL: URL? {
        if let path = movie.posterPath {
            return imageManager.posterURL(from: path, with: .w185)
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
            return DateFormatter.commonDisplayFormat.string(from: releaseDate)
        }

        return Constants.General.unknown
    }
}
