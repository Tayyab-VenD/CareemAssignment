//
//  MovieDBService.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum PosterSize : String {
    case w92
    case w185
    case w500
    case w780
}

protocol MovieDBService {
    func searchMovies(query: String, page: Int, completion: @escaping (_ result: Result<SearchResponse>) -> Void)
    func posterURL(from imagePath: String, with posterSize: PosterSize) -> URL?
}
