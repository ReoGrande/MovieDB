//
//  ImageCache.swift
//  RottenMovies
//
//  Created by Sinklier, Nick on 3/19/21.
//

import UIKit

/// Session-persistant cache used for improving image load performance.
class ImageCache: NSCache<AnyObject, UIImage> {
	static let shared = ImageCache()
}

// MARK: Image loader extension
extension UIImageView {
	func loadImage(from url: URL?) {
		guard let url = url else { return }
		
		if let cachedImage = ImageCache.shared.object(forKey: url as AnyObject) {
			image = cachedImage
		} else {
			URLSession.shared.dataTask(with: url) { data, response, error in
				guard let data = data else { return }
				DispatchQueue.main.async {
					guard let cacheImage = UIImage(data: data) else { return }
					ImageCache.shared.setObject(cacheImage, forKey: url as AnyObject)
					self.image = cacheImage
				}
			}
			.resume()
		}
	}
}
