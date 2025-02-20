//
//  MovieParser.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/18/21.
//

class MovieParser: MovieFactoryProtocol {
	func makeMovies(from json: [String: Any]) -> [MovieModel]? {
		guard let moviesJson = json["results"] as? [[String: Any]] else { return nil }
		var movies = [MovieModel]()
		for movie in moviesJson {
			if let title = movie["title"] as? String,
			   let imageURL = movie["poster_path"] as? String,
			   let overview = movie["overview"] as? String {
				let voteAverage = movie["vote_average"] as? Double
				let movieModel = MovieModel(title: title, overview: overview, imageURLPath: imageURL, voteAverage: voteAverage)
				movies.append(movieModel)
			}
		}
		return movies
	}
}
