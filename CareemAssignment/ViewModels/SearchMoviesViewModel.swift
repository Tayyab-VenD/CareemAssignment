//
//  SearchMoviesViewModel.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

class SearchMoviesViewModel {

    var service: MovieDBService
    var persistence: Persistence

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
                    self.notify(.noResultFound)
                } else {
                    // Save the query as suggestion.
                    self.persistence.saveSuggestion(Suggestion(text: query))

                    // Save the response for paging.
                    self.searchQuery = query
                    self.currentPage = value.page
                    self.totalPages = value.totalPages

                    if (page == 1) {
                        // Clear previous results if it is a new query.
                        self.searchResults.removeAll()
                    }
                    self.searchResults.append(contentsOf: value.results)
                    self.notify(.resultsUpdated)
                }

            case .failure(let error):
                self.notify(.apiError(error))
            }
        }
    }

    func refreshSuggestions() {
        persistence.fetchRecentSuggestions { (suggestions) in
            self.suggestions = suggestions
            self.notify(.suggestionsRefreshed)
        }
    }

    func searchMovies(query: String) {
        searchMovies(query: query, page: 1)
    }

    func loadMoreResults() {
        // Load next page of recent search query.
        searchMovies(query: searchQuery, page: currentPage + 1)
    }
}

// MARK: - EventObservable
extension SearchMoviesViewModel : EventObservable {

    enum Event {
        case suggestionsRefreshed
        case noResultFound
        case resultsUpdated
        case apiError(Error)
    }

    func on(_ observer: @escaping (Event) -> Void) {
        // Register the observer.
        self.observer = observer
    }

    private func notify(_ event: Event) {
        // Notify the event to observer.
        self.observer?(event)
    }
}

