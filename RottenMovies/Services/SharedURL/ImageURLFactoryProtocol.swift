//
//  ImageURLFactoryProtocol.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import Foundation

protocol ImageURLFactoryProtocol {
	/// Generates a complete URL for fetching an image.
	/// - parameter imagePath: String used to find image.
	/// - returns: Optional URL for service request.
	func makeMovieImageURL(imagePath: String) -> URL?
}
