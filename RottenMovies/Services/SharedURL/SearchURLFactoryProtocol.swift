//
//  SearchURLFactoryProtocol.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import Foundation

protocol SearchURLFactoryProtocol {
	/// Generates a complete URL for fetching a list of movies matching search requirements.
	/// - parameter searchString: String used to filter movie results.
	/// - returns: Optional URL for service request.
	func makeMovieSearchURL(searchString: String) -> URL?
}
