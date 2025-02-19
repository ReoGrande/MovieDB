//
//  MovieListServiceWorkerTests.swift
//  RottenMoviesTests
//
//  Created by Bilsky-Rollins, Simon on 4/29/24.
//

import Foundation
@testable import RottenMovies
import XCTest

class MovieListServiceWorkerTests: XCTestCase {
	func test_fetchMovies_success() {
		// given
		let serviceWorker = MovieListServiceWorker(urlFactory: MockURLFactory(), movieFactory: MockMovieParser(), urlSession: .mock)
		let expectation = XCTestExpectation(description: "Wait for fetch movies time out")

		// when
		var movies: [MovieModel]?
		serviceWorker.fetchMovies {
			movies = $0
		}

		// then
		DispatchQueue.main.async {
			XCTAssertEqual(movies?.count, 2) // this assertion fails periodically
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1.0)
	}
}

private class MockURLFactory: MoviesURLFactoryProtocol {
	func makeMoviesURL() -> URL? {
		URL(string: "https://www.example.com")
	}
}

private class MockMovieParser: MovieFactoryProtocol {
	func makeMovies(from json: [String: Any]) -> [MovieModel]? {
		[
			MovieModel(title: "Barbie", imageURLPath: ""),
			MovieModel(title: "Oppenheimer", imageURLPath: "")
		]
	}
}

private extension URLSession {
	static var mock: URLSession {
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		return URLSession(configuration: configuration)
	}
}

// https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
private class MockURLProtocol: URLProtocol {
	override class func canInit(with request: URLRequest) -> Bool {
		true
	}

	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		request
	}

	// simulate a successful, empty response to all requests
	override func startLoading() {
		client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
		client?.urlProtocol(self, didLoad: "{}".data(using: .utf8)!)
		client?.urlProtocolDidFinishLoading(self)
	}

	override func stopLoading() { }
}
