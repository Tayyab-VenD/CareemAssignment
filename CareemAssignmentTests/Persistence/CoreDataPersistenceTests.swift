//
//  CoreDataPersistenceTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 25/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import XCTest

@testable import CareemAssignment

class CoreDataPersistenceTests: XCTestCase {

    let coreDataStack = InMemoryCoreDataStack(name: "PersistenceModel")

    func testUniqueSuggestion() {
        // Create a sample suggestion.
        let sample = Suggestion(text: "text")

        // Save suggestion thrice.
        let persistence = CoreDataPersistence(coreDataStack)
        persistence.saveSuggestion(sample)
        persistence.saveSuggestion(sample)
        persistence.saveSuggestion(sample)

        let testExpectation = expectation(description: "Unique suggestion expectation")

        // There should be only one entry.
        persistence.fetchRecentSuggestions { (suggestions) in
            XCTAssertEqual(suggestions.count, 1)
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSuggestionOrder() {
        // Create sample suggestions.
        let samples = [
            Suggestion(text: "text1"),
            Suggestion(text: "text2"),
            Suggestion(text: "text3"),
        ]

        // Save all suggestions.
        let persistence = CoreDataPersistence(coreDataStack)
        for s in samples {
            persistence.saveSuggestion(s)
        }

        let testExpectation = expectation(description: "Suggestion order expectation")

        // Suggestions should be retrieved in reverse order.
        persistence.fetchRecentSuggestions { (suggestions) in
            XCTAssertEqual(suggestions, samples.reversed())
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
