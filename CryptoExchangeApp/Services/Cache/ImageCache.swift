//
//  ImageCache.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation
import UIKit

final class ImageCache {
    static let instance = ImageCache()
    private init() {}
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func imageFromCache(url: String) -> UIImage? {
        if let image = imageCache.object(forKey: url as NSString) {
            return image
        }
        return nil
    }
    
    func cacheImage(url: String, image: UIImage) {
        imageCache.setObject(image, forKey: url as NSString)
    }
}
