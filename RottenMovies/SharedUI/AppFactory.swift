//
//  AppFactory.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/14/21.
//

import UIKit

class AppFactory {
	
	enum Tab: Int {
		case home
		case search
	}
	
	// MARK: UI
	public func makeTabBarController() -> UITabBarController {
		let tabBarController = UITabBarController()
		tabBarController.tabBar.backgroundColor = .white
		tabBarController.viewControllers = [makeHomeViewController(), makeSearchViewController()]
		tabBarController.tabBar.items?[Tab.home.rawValue].image = UIImage(systemName: "video.circle.fill")
        tabBarController.tabBar.items?[Tab.home.rawValue].title = "Best Movies"
		tabBarController.tabBar.items?[Tab.search.rawValue].image = UIImage(systemName: "magnifyingglass.circle.fill")
        tabBarController.tabBar.items?[Tab.search.rawValue].title = "Search"
		return tabBarController
	}
	
	private func makeHomeViewController() -> UIViewController {
		UINavigationController(rootViewController: HomeViewController(serviceWorker: makeHomeServiceWorker()))
	}
	
	private func makeSearchViewController() -> UIViewController {
		UINavigationController(rootViewController: SearchViewController(serviceWorker: makeSearchServiceWorker()))
	}
	
	// MARK: Tools
	private func makeHomeURLFactory() -> MoviesURLFactoryProtocol {
		HomeURLFactory()
	}
	
	private func makeSearchURLFactroy() -> SearchURLFactoryProtocol {
		SearchURLFactory()
	}
	
	private func makeHomeServiceWorker() -> MovieListServiceWorkerProtocol {
		MovieListServiceWorker(urlFactory: makeHomeURLFactory(), movieFactory: makeMovieFactory())
	}
	
	private func makeSearchServiceWorker() -> MovieSearchServiceWorkerProtocol {
		MovieSearchServiceWorker(urlFactory: makeSearchURLFactroy(), movieFactory: makeMovieFactory())
	}
	
	private func makeMovieFactory() -> MovieFactoryProtocol {
		MovieParser()
	}
}
