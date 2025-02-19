//
//  ImageURLFactory.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import Foundation

class ImageURLFactory: ImageURLFactoryProtocol {
	func makeMovieImageURL(imagePath: String) -> URL? {
		URL(string: API.imageBaseURL + imagePath + "?" + API.apiKey)
	}
}
