//
//  StubMovieDBService.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

@testable import CareemAssignment

class StubMovieDBService : MovieDBService {

    var searchResult: Result<SearchResponse>!
    var posterURL: URL!

    func searchMovies(query: String, page: Int, completion: @escaping (_ result: Result<SearchResponse>) -> Void) {
        completion(searchResult)
    }

    func posterURL(from imagePath: String, with posterSize: PosterSize) -> URL? {
        return posterURL
    }
}
