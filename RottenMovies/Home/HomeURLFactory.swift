//
//  HomeURLFactory.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/18/21.
//

import Foundation

class HomeURLFactory: MoviesURLFactoryProtocol {
	func makeMoviesURL() -> URL? {
		URL(string: API.baseURL + API.discoverPath + "?" + API.apiKey + "&" + API.popularOrder)
	}
}
