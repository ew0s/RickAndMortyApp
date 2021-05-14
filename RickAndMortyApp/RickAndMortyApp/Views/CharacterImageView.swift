//
//  CharacterImageView.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 13.05.2021.
//

import UIKit

class CharacterImageView: UIImageView {
    
    // MARK: - Public methods
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = UIImage(named: "defaultAvatar")
            return
        }
        
        // Using image from cache if exist
        if let cachedImage = getCachedImage(from: imageUrl) {
            image = cachedImage
            return
        }
        
        // Download image if it's not exist
        NetworkImageManager.shared.fetchImage(from: imageUrl) { data, response in
            self.image = UIImage(data: data)
            
            // saving image to cache
            self.saveDataToCache(with: data, and: response)
        }
    }
}

// MARK: - Private methods
extension CharacterImageView {
    
    private func getCachedImage(from imageUrl: URL) -> UIImage? {
        let request = URLRequest(url: imageUrl)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cahchedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cahchedResponse, for: request)
    }
}
