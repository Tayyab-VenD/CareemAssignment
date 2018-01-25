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
    private var persistence: Persistence

    private var searchQuery: String = ""
    private var currentPage: Int = 0
    private var totalPages: Int = 0

    private(set) var suggestions = [Suggestion]()
    private(set) var searchResults = [Movie]()

    var hasMoreResults: Bool {
        return currentPage < totalPages
    }

    private var observer: ((_ event: Event) -> Void)?

    init(service: MovieDBService, persistence: Persistence) {
        self.service = service
        self.persistence = persistence
    }

    private func searchMovies(query: String, page: Int) {
        service.searchMovies(query: query, page: page) { (result) in
            switch result {
            case .success(let value):
                if page == 1 && value.results.count == 0 {
                    self.observer?(.noResultFound)
                } else {
                    // Save the query as suggestion.
                    self.persistence.saveSuggestion(Suggestion(text: query))

                    self.searchQuery = query
                    self.currentPage = value.page
                    self.totalPages = value.totalPages

                    if (page == 1) {
                        self.searchResults.removeAll()
                    }
                    self.searchResults.append(contentsOf: value.results)
                    self.observer?(.didUpdateResults)
                }

            case .failure(let error):
                self.observer?(.didReceiveError(error))
            }
        }
    }

    func refreshSuggestions() {
        persistence.fetchRecentSuggestions { (suggestions) in
            self.suggestions = suggestions
            self.observer?(.suggestionsRefreshed)
        }
    }

    func searchMovies(query: String) {
        searchMovies(query: query, page: 1)
    }

    func loadMoreResults() {
        searchMovies(query: searchQuery, page: currentPage + 1)
    }
}

extension SearchMoviesViewModel {

    enum Event {
        case suggestionsRefreshed
        case noResultFound
        case didReceiveError(Error)
        case didUpdateResults
    }

    func on(_ observer: @escaping (Event) -> Void) {
        self.observer = observer
    }
}

