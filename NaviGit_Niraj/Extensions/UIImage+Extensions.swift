//
//  UIImage+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import UIKit

extension UIImageView {
    /// Load an image
    /// - Parameters:
    ///   - url: Image URL
    ///   - placeholder: Placeholder image to set the image for failed download image
    ///   - completion: Pass a completion to notify that the status of image
    func load(url: URL, placeholder: UIImage? = nil, completion: ((Bool) -> Void)? = nil) {
        ImageDownloader.shared.load(url: url as NSURL) { image in
            if let image = image {
                self.image = image
                completion?(true)
            } else {
                self.image = placeholder
                completion?(false)
            }
        }
    }
}
