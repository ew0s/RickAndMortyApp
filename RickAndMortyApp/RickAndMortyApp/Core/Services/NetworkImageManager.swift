//
//  NetworkImageManager.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 09.05.2021.
//

import Foundation

class NetworkImageManager {
    
    // MARK: - Public properties
    static let shared = NetworkImageManager()
    
    // MARK: - Public methods
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No description for error")
                return
            }
            
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
    
    // MARK: - Initialization
    private init() {}
}
