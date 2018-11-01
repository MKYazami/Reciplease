//
//  UIImageView.swift
//  Reciplease
//
//  Created by Mehdi on 10/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

extension UIImageView {
    /// Load an image from url in remote API or web site.
    /// In case url string is nil or it can not be converted to a URL a default image will be affected.
    ///
    /// - Parameter urlImageString: url string whitch contains the image
    func loadFromRemote(urlImageString: String?) {
        guard let urlImageString = urlImageString else {
            self.image = UIImage(imageLiteralResourceName: UIImageNames.defaultImage.rawValue)
            return
        }
        
        // We change the the image size in url to get greater image
        let urlImageStringWithGreaterSize = urlImageString.replacingOccurrences(of: "=s90", with: "=s1000")
        guard let urlImage = URL(string: urlImageStringWithGreaterSize) else {
            self.image = UIImage(imageLiteralResourceName: UIImageNames.defaultImage.rawValue)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: urlImage) else { return }
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        
    }
}
