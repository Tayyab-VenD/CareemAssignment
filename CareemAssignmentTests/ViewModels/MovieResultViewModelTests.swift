//
//  MovieResultViewModelTests.swift
//  CareemAssignmentTests
//
//  Created by Muhammad Tayyab Akram on 30/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import XCTest

@testable import CareemAssignment

class MovieResultViewModelTests: XCTestCase {

    private var imageManager: ImageManager!

    override func setUp() {
        super.setUp()

        imageManager = ImageManager(APIConfiguration.stub)
    }

    func testViewModel() {
        let sample = Movie(
            id: 1,
            overview: nil,
            posterPath: nil,
            releaseDate: Date(timeIntervalSince1970: 0),
            title: ""
        )
        let viewModel = MovieResultViewModel(sample, imageManager: imageManager)

        XCTAssertEqual(viewModel.overview, "", "The overview is not the expected one")
        XCTAssertEqual(viewModel.posterURL, nil, "The poster url is not the expected one")
        XCTAssertEqual(viewModel.releaseDate, "Jan 1, 1970", "The release date is not the expected one")
        XCTAssertEqual(viewModel.title, "", "The title is not the expected one")
    }
}
