//
//  BreachCache.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import Foundation

class BreachCache {
    public static let shared = BreachCache()
    
    private var cache = NSCache<NSString, NSArray>()
    
    func get(forKey: String) -> [Breach]? {
        return cache.object(forKey: NSString(string: forKey)) as? [Breach]
    }
    
    func set(_ breaches: [Breach], forKey: String) {
        cache.setObject(breaches as NSArray, forKey: NSString(string: forKey))
    }
}
