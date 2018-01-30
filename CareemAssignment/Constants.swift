//
//  Constants.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 29/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

struct Constants {
    struct MovieDB {
        static let apiBaseURL = "http://api.themoviedb.org/3"
        static let imageBaseURL = "http://image.tmdb.org/t/p"
        static let apiKey = "2696829a81b1b5827d515ff121700838"
    }
    struct Alert {
        static let networkError = "An unknown error occurred. Please check your internet connection and try again later."
    }
    struct General {
        static let unknown = "Unknown"
        static let ok = "OK"
    }
}
