//
//  SearchViewController.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/14/21.
//

import UIKit

class SearchViewController: UIViewController {
	// MARK: Properties
	private let serviceWorker: MovieSearchServiceWorkerProtocol
	private var searchData: Data?
	var searchBar: UISearchBar?
	var collectionView: UICollectionView?
	var movieModels = [MovieModel]()
	
	// MARK: Init
	init(serviceWorker: MovieSearchServiceWorkerProtocol) {
		self.serviceWorker = serviceWorker
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Search"
		navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.5647, blue: 0, alpha: 1.0)
		view.backgroundColor = .white
		setupSearchBar()
		setupCollectionView()
	}
	
	// MARK: UI
	func setupSearchBar() {
		let yValue = (navigationController?.navigationBar.frame.size.height ?? 40) + 40
		searchBar = UISearchBar(frame: CGRect(x: 0, y: yValue, width: view.frame.width, height: 50))
		guard let searchBar = searchBar else { return }
		searchBar.delegate = self
		searchBar.placeholder = "Search"
		searchBar.barTintColor = UIColor(red: 0.5059, green: 0.3608, blue: 0.7098, alpha: 1.0)
		view.addSubview(searchBar)
	}
	
	func setupCollectionView() {
		guard let searchBar = searchBar else { return }
		let padding: CGFloat = 10
		let width: CGFloat = view.frame.width / 2 - 3*padding
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: width, height: 1.75*width)
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		
		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
		guard let collectionView = collectionView else { return }
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
		collectionView.backgroundColor = .systemTeal
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.clipsToBounds = true
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
		collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	// MARK: Populate movies
	func populateMovies(with searchString: String) {
		collectionView?.reloadData()
		serviceWorker.fetchSearch(searchString) { [weak self] movies in
			guard let self = self else { return }
			self.movieModels = movies ?? [MovieModel]()
			self.collectionView?.reloadData()
		}
	}
}

// MARK: SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		populateMovies(with: searchString)
		searchBar.resignFirstResponder()
	}
}

// MARK: CollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		movieModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
		cell.movieModel = movieModels[indexPath.row]
		return cell
	}
}

// MARK: CollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let viewController = DetailsFactory.makeViewController(for: movieModels[indexPath.row])
		navigationController?.pushViewController(viewController, animated: true)
	}
}
