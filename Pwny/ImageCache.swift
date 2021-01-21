//
//  ImageCache.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation
import UIKit

class ImageCache {
    public static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(_ image: UIImage, forKey: String) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
