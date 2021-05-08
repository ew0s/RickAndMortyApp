//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

import Alamofire

class NetworkManager {
    
    // MARK: - Public variables
    static let shared = NetworkManager()
    
    // MARK: - Public methods
    func fetchData(from url: String?, with complition: @escaping (RickAndMorty) -> Void) {
        
        guard let stringURL = url else { return }
        AF.request(stringURL)
            .validate()
            .responseDecodable(of: RickAndMorty.self) { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    complition(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchEpisode(from url: String?, completion: @escaping(Episode) -> Void) {
        
        guard let stringURL = url else { return }
        AF.request(stringURL)
            .validate()
            .responseDecodable(of: Episode.self) { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchCharacter(from url: String?, with complition: @escaping (Character) -> Void) {
        
        guard let stringURL = url else { return }
        AF.request(stringURL)
            .validate()
            .responseDecodable(of: Character.self) { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    complition(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - Initialization
    private  init() {}
}
