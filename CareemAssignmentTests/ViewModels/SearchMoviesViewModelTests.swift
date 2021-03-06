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

    var client: StubAPIClient!
    var repository: StubSuggestionRepository!
    var viewModel: SearchMoviesViewModel!

    override func setUp() {
        super.setUp()

        client = StubAPIClient()
        repository = StubSuggestionRepository()
        viewModel = SearchMoviesViewModel(client: client, repository: repository)
    }

    func testSuggestionsRefreshedEvent() {
        repository.recent = []

        let expectation = self.expectation(description: "Suggestions refreshed event expectation")

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
        client.webResponse = SearchResponse.stub().jsonWebResponse

        let expectation = self.expectation(description: "No result found event expectation")

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
        client.webResponse = SearchResponse.stub(results: 1).jsonWebResponse

        let expectation = self.expectation(description: "Results updated event expectation")

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
        client.webResponse = WebResponse(error: NSError.stub)

        let expectation = self.expectation(description: "API error event expectation")

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
