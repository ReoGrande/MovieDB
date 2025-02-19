//
//  DetailsFactory.swift
//  RottenMovies
//
//  Created by Bilsky-Rollins, Simon on 11/1/23.
//

import SwiftUI

struct DetailsFactory {
	static func makeViewController(for movie: MovieModel) -> UIViewController {
		let viewModel = DetailsViewModel(movie: movie)
		let view = DetailsView(viewModel: viewModel)
		return UIHostingController(rootView: view)
	}
}
