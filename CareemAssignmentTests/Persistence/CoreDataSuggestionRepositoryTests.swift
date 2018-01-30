//
//  CoreDataSuggestionRepositoryTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import XCTest

@testable import CareemAssignment

class CoreDataSuggestionRepositoryTests: XCTestCase {

    private var repository: CoreDataSuggestionRepository!

    override func setUp() {
        super.setUp()

        let coreDataStack = InMemoryCoreDataStack(name: "PersistenceModel")
        repository = CoreDataSuggestionRepository(coreDataStack)
    }

    func testUniqueSuggestion() {
        let sample = Suggestion.stub

        // Save suggestion thrice.
        for _ in 1...3 {
            repository.save(sample)
        }

        let expectation = self.expectation(description: "Unique suggestion expectation")

        repository.fetchRecent { (suggestions) in
            XCTAssertEqual(suggestions.count, 1, "The suggestion is not saved with unique constraint")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSuggestionOrder() {
        let samples = [
            Suggestion(text: "text1"),
            Suggestion(text: "text2"),
            Suggestion(text: "text3"),
        ]

        // Save all suggestions.
        for entry in samples {
            repository.save(entry)
        }

        let expectation = self.expectation(description: "Suggestion order expectation")

        repository.fetchRecent { (suggestions) in
            XCTAssertEqual(suggestions, samples.reversed(), "The order of suggestions is not most recent to least recent")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
