//
//  SearchRequestTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import XCTest

@testable import CareemAssignment

class SearchRequestTests: XCTestCase {

    private var configuration: APIConfiguration!
    private var client: ParsableURLSesssionAPIClient!

    override func setUp() {
        super.setUp()
        client = ParsableURLSesssionAPIClient()
        configuration = client.configuration
    }

    func testWebRequest() {
        let sample = SearchRequest(query: "query", page: 1)
        let expected = WebRequest(
            method: .get,
            url: URL(
                base: configuration.baseURL,
                path: "/search/movie",
                parameters: [
                    "api_key": configuration.apiKey,
                    "query": "query",
                    "page": "1"
                ]
                )!
        )

        let value = sample.webRequest(with: configuration)

        XCTAssertEqual(value, expected, "The web request is not the expected one")
    }

    func testSearchMoviesSuccess() {
        let sample = """
        {
            "page": 1,
            "results": [
                {
                    "id": 1,
                    "overview": "overview",
                    "poster_path": "poster_path",
                    "release_date": "1970-01-01",
                    "title": "title"
                }
            ],
            "total_results": 1,
            "total_pages": 1
        }
        """
        client.webResponse = WebResponse(string: sample)

        let expected = SearchResponse(
            page: 1,
            results: [
                Movie(
                    id: 1,
                    overview: "overview",
                    posterPath: "poster_path",
                    releaseDate: Date(timeIntervalSince1970: 0),
                    title: "title"
                )
            ],
            totalResults: 1,
            totalPages: 1
        )

        let expectation = self.expectation(description: "Search movies success expectation")

        let request = SearchRequest(query: "query", page: 1)
        client.execute(request) { (result) in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expected, "The result is not the expected one")
            case .failure(_):
                XCTFail("A successfull response should've been returned")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSearchMoviesFailure() {
        let sample = NSError.stub()
        client.webResponse = WebResponse(error: sample)

        let expectation = self.expectation(description: "Search movies failure expectation")

        let request = SearchRequest(query: "query", page: 1)
        client.execute(request) { (result) in
            switch result {
            case .success(_):
                XCTFail("Expected test error to be received")
            case .failure(let error as NSError):
                XCTAssertEqual(error, sample, "The error is not the expected one")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
