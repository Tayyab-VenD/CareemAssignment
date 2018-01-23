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

protocol MovieDBService {
    func searchMovies(query: String, page: Int, completion: @escaping (_ result: Result<SearchResponse>) -> Void)
}
