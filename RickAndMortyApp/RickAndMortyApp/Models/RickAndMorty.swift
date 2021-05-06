//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String?
    let episode: [String]
    let url: String
    
    var description: String {
        """
        Name: \(name)
        Status: \(status)
        Species: \(species)
        Gender: \(gender)
        Origin: \(origin)
        Location: \(location.name)
        """
    }
}

struct Episode {
    let name: String
    let air_date: String
    let characters: [String]
    let url: String
}

struct Location: Decodable {
    let name: String
}

enum URLS: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}
