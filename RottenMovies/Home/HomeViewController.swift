//
//  ViewController.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/13/21.
//

import UIKit

class HomeViewController: UIViewController {
	// MARK: Properties
	let serviceWorker: MovieListServiceWorkerProtocol
	var collectionView: UICollectionView?
	var movieModels = [MovieModel]()
	
	// MARK: Init
	init(serviceWorker: MovieListServiceWorkerProtocol) {
		self.serviceWorker = serviceWorker
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		populateMovies()
		title = "Best Movies"
		setupContent()
	}
	
	func setupContent() {
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
		
		view.addSubview(collectionView)
	}
	
	// MARK: Populate movies
	func populateMovies() {
		serviceWorker.fetchMovies { [weak self] movies in
			guard let self = self else { return }
			self.movieModels = movies ?? [MovieModel]()
			self.collectionView?.reloadData()
		}
	}
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		movieModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
		cell.movieModel = movieModels[indexPath.row]
		return cell
	}
}

extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let viewController = DetailsFactory.makeViewController(for: movieModels[indexPath.row])
		navigationController?.pushViewController(viewController, animated: true)
	}
}
