//
//  MovieListServiceWorker.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/18/21.
//

import Foundation

public protocol MovieListServiceWorkerProtocol {
	func fetchMovies(completion: @escaping ([MovieModel]?)->())
}

class MovieListServiceWorker: MovieListServiceWorkerProtocol {
	let urlFactory: MoviesURLFactoryProtocol
	let movieFactory: MovieFactoryProtocol
	let urlSession: URLSession

	init(
		urlFactory: MoviesURLFactoryProtocol,
		movieFactory: MovieFactoryProtocol,
		urlSession: URLSession = .shared
	) {
		self.urlFactory = urlFactory
		self.movieFactory = movieFactory
		self.urlSession = urlSession
	}
	
	func fetchMovies(completion: @escaping ([MovieModel]?)->()) {
		guard let url = urlFactory.makeMoviesURL() else { return }
		
		urlSession.dataTask(with: url) { data, response, error in
			guard let httpResponse = response as? HTTPURLResponse,
				  httpResponse.statusCode == 200,
				  let data = data,
				  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
			
			let movieModels = self.movieFactory.makeMovies(from: json)
			completion(movieModels)
		}
		.resume()
	}
}
