//
//  SearchMoviesViewModelTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 26/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//
import Foundation
import XCTest

@testable import CareemAssignment

class SearchMoviesViewModelTests: XCTestCase {

    var service: StubMovieDBService!
    var persistence: StubPersistence!
    var viewModel: SearchMoviesViewModel!

    override func setUp() {
        super.setUp()

        service = StubMovieDBService()
        persistence = StubPersistence()
        viewModel = SearchMoviesViewModel(service: service, persistence: persistence)
    }

    func testSuggestionsRefreshedEvent() {
        let expectation = self.expectation(description: "Suggestions refreshed event expectation")

        persistence.recentSuggestions = []

        viewModel.on { (event) in
            switch event {
            case .suggestionsRefreshed:
                break
            default:
                XCTFail("Expected `suggestions refreshed` event to be notified")
            }

            expectation.fulfill()
        }
        viewModel.refreshSuggestions()

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testNoResultFoundEvent() {
        let expectation = self.expectation(description: "No result found event expectation")

        service.searchResult = .success(SearchResponse.stub())

        viewModel.on { (event) in
            switch event {
            case .noResultFound:
                break
            default:
                XCTFail("Expected `no result found` event to be notified")
            }

            expectation.fulfill()
        }
        viewModel.searchMovies(query: "query")

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testResultsUpdatedEvent() {
        let expectation = self.expectation(description: "Results updated event expectation")

        service.searchResult = .success(SearchResponse.stub(results: 1))

        viewModel.on { (event) in
            switch event {
            case .resultsUpdated:
                break
            default:
                XCTFail("Expected `results updated` event to be notified")
            }

            expectation.fulfill()
        }
        viewModel.searchMovies(query: "query")

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testAPIErrorEvent() {
        let expectation = self.expectation(description: "API error event expectation")

        service.searchResult = .failure(NSError.stub())

        viewModel.on { (event) in
            switch event {
            case .apiError(_):
                break
            default:
                XCTFail("Expected `api error` event to be notified")
            }

            expectation.fulfill()
        }
        viewModel.searchMovies(query: "query")

        waitForExpectations(timeout: 1, handler: nil)
    }
}
