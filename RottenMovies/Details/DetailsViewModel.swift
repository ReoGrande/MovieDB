//
//  DetailsViewModel.swift
//  RottenMovies
//
//  Created by Bilsky-Rollins, Simon on 11/1/23.
//

import SwiftUI

final class DetailsViewModel: ObservableObject {
	var image: UIImage?

	private let movie: MovieModel

	init(movie: MovieModel) {
		self.movie = movie
	}

	var title: String {
		movie.title
	}

	var overview: String? {
		movie.overview
	}

	func fetchImage() async {
		guard let url = movie.imageURL else { return }

		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			image = UIImage(data: data)
		} catch {
			return
		}
	}
}
