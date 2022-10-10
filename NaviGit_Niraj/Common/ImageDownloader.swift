//
//  ImageDownloader.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()

    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?) -> Void]]()

    private init() { }

    func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }

    /// Returns the cached image if available, otherwise asynchronously loads and caches it.
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: Dpwnloaded image or the cached image
    func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }

        let dataTask = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
                let imageBlocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)

            for imageBlock in imageBlocks {
                DispatchQueue.main.async {
                    imageBlock(image)
                }
                return
            }
        }
        dataTask.resume()
    }
}
