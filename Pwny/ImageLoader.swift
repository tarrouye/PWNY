//
//  ImageLoader.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI
import Combine
import UIKit
import Foundation

class ImageLoader : ObservableObject {
    @Published var image : UIImage? = nil
    private let url : URL
    private var session : URLSessionDataTask?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        self.cancelLoad()
    }
    
    func load() {
        // check cache first
        if let img = ImageCache.shared.get(forKey: self.url.absoluteString) {
            self.image = img
        } else {
            // load from URL
            self.session = URLSession.shared.dataTask(with: self.url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // store in cache and set/publish result
                        ImageCache.shared.set(img, forKey: self.url.absoluteString)
                        self.image = img
                    }
                }
            }
            
            self.session?.resume()
        }
    }
    
    func cancelLoad() {
        self.session?.cancel()
    }
}
