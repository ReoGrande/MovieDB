//
//  MovieFactoryProtocol.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

protocol MovieFactoryProtocol {
	/// Generates a list of movies from JSON dictionary.
	/// - parameter json: dictionary used to populate MovieModel list
	/// - returns: Array or movie models generated from the json.
	func makeMovies(from json: [String: Any]) -> [MovieModel]?
}
