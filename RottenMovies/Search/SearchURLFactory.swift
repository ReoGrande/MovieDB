//
//  SearchURLFactory.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import Foundation

class SearchURLFactory: SearchURLFactoryProtocol {
	public func makeMovieSearchURL(searchString: String) -> URL? {
		URL(string: API.baseURL + API.searchPath + "?" + API.apiKey + "&" + API.searchQuery + searchString.replacingOccurrences(of: " ", with: "+"))
	}
}
