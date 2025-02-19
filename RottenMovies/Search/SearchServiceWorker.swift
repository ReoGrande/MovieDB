//
//  SearchServiceWorker.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/18/21.
//

import Foundation

// MARK: Protocol
protocol MovieSearchServiceWorkerProtocol {
	func fetchSearch(_ searchString: String, completion: @escaping ([MovieModel]?)->())
}

// MARK: Implementation
class MovieSearchServiceWorker: MovieSearchServiceWorkerProtocol {
	let urlFactory: SearchURLFactoryProtocol
	let movieFactory: MovieFactoryProtocol
	
	init(urlFactory: SearchURLFactoryProtocol, movieFactory: MovieFactoryProtocol) {
		self.urlFactory = urlFactory
		self.movieFactory = movieFactory
	}
	
	func fetchSearch(_ searchString: String, completion: @escaping ([MovieModel]?) -> ()) {
		guard let url = urlFactory.makeMovieSearchURL(searchString: searchString) else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let httpResponse = response as? HTTPURLResponse,
				  httpResponse.statusCode == 200,
				  let data = data,
				  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
			
			let movieModels = self.movieFactory.makeMovies(from: json)
			
			DispatchQueue.main.async {
				completion(movieModels)
			}
		}
		.resume()
	}
}
