//
//  SearchMoviesViewModel.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class SearchMoviesViewModel {

    private var service: MovieDBService

    private var searchQuery: String = ""
    private var currentPage: Int = -1
    private var totalPages: Int = 0

    private(set) var searchResults: [Movie] = [Movie]()

    private var observer: ((_ event: Event) -> Void)?

    init(service: MovieDBService) {
        self.service = service
    }

    private func searchMovies(query: String, page: Int) {
        service.searchMovies(query: query, page: page) { (result) in
            switch result {
            case .success(let value):
                self.searchQuery = query
                self.currentPage = value.page
                self.totalPages = value.totalPages

                if (query != self.searchQuery || page == 1) {
                    self.searchResults.removeAll()
                }
                self.searchResults.append(contentsOf: value.results)
                self.observer?(.didUpdateResults)

            case .failure(let error):
                self.observer?(.didReceiveError(error))
            }
        }
    }

    func searchMovies(query: String) {
        searchMovies(query: query, page: 1)
    }

    func loadMore() {
        searchMovies(query: searchQuery, page: currentPage + 1)
    }
}

extension SearchMoviesViewModel {

    enum Event {
        case didReceiveError(Error)
        case didUpdateResults
    }

    func on(_ observer: @escaping (Event) -> Void) {
        self.observer = observer
    }
}
