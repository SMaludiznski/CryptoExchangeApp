//
//  UIImageView+Extension.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 09/03/2022.
//

import Foundation
import UIKit

extension UIImageView {
    @discardableResult
    func loadImageFrom(url urlString: String) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = ImageCache.instance.imageFromCache(url: urlString) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    ImageCache.instance.cacheImage(url: urlString, image: downloadedImage)
                }
            }
        }
        
        task.resume()
        return task
    }
}
