//
//  MovieCell.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/16/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
	// MARK: Properties
	private var imageView = UIImageView(image: UIImage(systemName: "icloud"))
	private let titleLabel = UILabel()
	private let voteAverageLabel = UILabel()
	public static let identifier = "MovieCell"
	var movieModel: MovieModel? {
		didSet {
			imageView.loadImage(from: movieModel?.imageURL)
			titleLabel.text = movieModel?.title
			
			if let voteAverage = movieModel?.voteAverage {
				voteAverageLabel.isHidden = false
				voteAverageLabel.text = String(format: "%0.1f / 10", voteAverage)
				
				if voteAverage >= 7.5 {
					backgroundColor = .orange
				}
			} else {
				voteAverageLabel.isHidden = true
			}
		}
	}
	
	// MARK: Init
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupImage()
		setupTitle()
		setupVoteAverage()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: UI
	func setupImage() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		contentView.addSubview(imageView)
		imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
	}
	
	func setupTitle() {
		titleLabel.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = "loading..."
		titleLabel.textAlignment = .left
		contentView.addSubview(titleLabel)
		titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
	}
	
	func setupVoteAverage() {
		voteAverageLabel.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 15.0)
		voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
		voteAverageLabel.textAlignment = .left
		contentView.addSubview(voteAverageLabel)
		voteAverageLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		voteAverageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
	}
}
