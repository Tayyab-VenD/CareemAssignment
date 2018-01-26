//
//  MovieDBWebServiceTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Alamofire
import Foundation
import Mockingjay
import XCTest

@testable import CareemAssignment

class MovieDBWebServiceTests: XCTestCase {

    private var service: MovieDBWebService!

    override func setUp() {
        super.setUp()
        service = MovieDBWebService(SessionManager.default)
    }

    func testSearchMoviesSuccess() {
        let sample: [String: Any] = [
            "page": 1,
            "results": [
                ["id": 1,
                 "overview": "overview",
                 "poster_path": "poster_path",
                 "release_date": "1970-01-01",
                 "title": "title"]
            ],
            "total_results": 1,
            "total_pages": 1
        ]
        stub(everything, json(sample))

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

        service.searchMovies(query: "query", page: 1) { (result) in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expected, "The result is not the expected one")
            case .failure(_):
                XCTFail("A successfull response should've been returned")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        defer {
            removeAllStubs()
        }
    }

    func testSearchMoviesFailure() {
        let sample = NSError.stub()
        stub(everything, failure(sample))

        let expectation = self.expectation(description: "Search movies failure expectation")

        service.searchMovies(query: "query", page: 1) { (result) in
            switch result {
            case .success(_):
                XCTFail("Expected test error to be received")
            case .failure(let error as NSError):
                XCTAssertEqual(error, sample, "The error is not the expected one")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        defer {
            removeAllStubs()
        }
    }
}
