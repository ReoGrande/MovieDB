//
//  MovieParserTests.swift
//  RottenMoviesTests
//
//  Created by Bilsky-Rollins, Simon on 4/29/24.
//

import Foundation
@testable import RottenMovies
import XCTest

class MovieParserTests: XCTestCase {
	// Write a test for MovieParser's makeMovies method that uses `testJSON`
	func test_makeMovies_usingTestJSON() throws {
		// Given
		let testJson: [String: Any] = ["results":
										[
											["title": "Oppenheimer", "poster_path": "Oppenheimer: Poster", "overview": "Oppenheimer: Overview"],
											["title": "Barbie", "poster_path": "Barbie: Poster", "overview": "Barbie: Overview"],
											["movieTitle": "The Social Network", "poster_path": "The Social Network: Poster", "overview": "The Social Network: Overview"],
											["title": "The Departed", "poster_path": "The Departed: Poster"]
										]
		]

		let movieFactory = MovieParser()
		XCTFail("Write test")
	}
}
