//
//  PasteCache.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

class PasteCache {
    public static let shared = PasteCache()
    
    private var cache = NSCache<NSString, NSArray>()
    
    func get(forKey: String) -> [Paste]? {
        return cache.object(forKey: NSString(string: forKey)) as? [Paste]
    }
    
    func set(_ pastes: [Paste], forKey: String) {
        cache.setObject(pastes as NSArray, forKey: NSString(string: forKey))
    }
}
