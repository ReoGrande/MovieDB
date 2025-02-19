//
//  DetailsView.swift
//  RottenMovies
//
//  Created by Bilsky-Rollins, Simon on 11/1/23.
//

import SwiftUI

struct DetailsView: View {
	var viewModel: DetailsViewModel

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			image
			title
			overview
		}
		.task {
			await viewModel.fetchImage()
		}
		.padding(16)
	}

	@ViewBuilder var image: some View {
		if let image = viewModel.image {
			Image(uiImage: image)
				.resizable()
				.cornerRadius(16)
		}
	}

	var title: some View {
		Text(viewModel.title)
			.font(.title)
	}

	@ViewBuilder var overview: some View {
		if let overview = viewModel.overview {
			Text(overview)
				.font(.body)
				.background(Color.gray)
				.padding(16)
				.cornerRadius(16)
		}
	}
}
