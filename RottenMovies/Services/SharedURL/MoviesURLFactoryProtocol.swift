//
//  MoviesURLFactoryProtocol.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/14/21.
//

import Foundation

protocol MoviesURLFactoryProtocol {
	/// Generates a complete URL for fetching a list of movies.
	/// - returns: Optional URL for service request.
	func makeMoviesURL() -> URL?
}
