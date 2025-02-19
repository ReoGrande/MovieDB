//
//  APIComponents.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import Foundation

struct API {
	static let baseURL = "http://api.themoviedb.org/3/"
	static let discoverPath = "discover/movie"
	static let popularOrder = "sort_by=popularity.desc"
	static let imageBaseURL = "http://image.tmdb.org/t/p/w500"
	static let searchPath = "search/movie"
	static let searchQuery = "query="
	static let apiKey = "api_key=789a3ad9fb130b33628be0e27eaf57c8"
}
