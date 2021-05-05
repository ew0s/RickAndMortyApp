//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

import Foundation

class NetworkManager {
    
    // MARK: - Public variables
    static let shared = NetworkManager()
    
    // MARK: - Public methods
    func fetchData(from url: String?, with complition: @escaping (RickAndMorty) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data,_,error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    complition(rickAndMorty)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchCharacter(from url: String?, with complition: @escaping (Character) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data,_,error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    complition(character)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    // MARK: - Initialization
    private  init() {}
}

// MARK: - Private methods
extension NetworkManager {
}
