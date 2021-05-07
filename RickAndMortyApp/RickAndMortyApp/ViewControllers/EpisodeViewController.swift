//
//  EpisodeViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 06.05.2021.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var episodeDescriptionLabel: UILabel!
    @IBOutlet var episodeCharactersTableView: UITableView!
    
    // MARK: - Public properties
    var episodeURL: String!
    var episode: Episode?
    var episodeCharacters: [Character] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
}

// MARK: - Private methods
extension EpisodeViewController {
    private func setViewController() {
        episodeCharactersTableView.rowHeight = 80
        episodeCharactersTableView.dataSource = self
        episodeCharactersTableView.delegate = self
        
        guard let stringURL = episodeURL else { return }
        
        NetworkManager.shared.fetchEpisode(from: stringURL) { episode in
            self.episode = episode
            self.title = episode.name
            self.episodeDescriptionLabel.text = episode.description
            
            for characterURL in episode.characters {
                NetworkManager.shared.fetchCharacter(from: characterURL) { character in
                    self.episodeCharacters.append(character)
                    self.episodeCharactersTableView.reloadData()
                }
            }
        }
    }
}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode?.characters.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        
        if episodeCharacters.indices.contains(indexPath.row) {
            let character = episodeCharacters[indexPath.row]
            configuration.text = character.name
            configuration.textProperties.color = .white
            
            if let imageData = NetworkImageManager.shared.fetchImage(from: character.image) {
                configuration.image = UIImage(data: imageData)
                configuration.imageProperties.cornerRadius = (configuration.image?.size.height)! / 2
            }
        }

        cell.contentConfiguration = configuration
        
        return cell
    }
}

// MARK: - Table view delegate
extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let characterUrl = episode?.characters[indexPath.row]
//        performSegue(withIdentifier: "showCharacter", sender: characterUrl)
        //print(episodeCharactersTableView.indexPathForSelectedRow?.row ?? 0)
        print(episodeCharacters.count)
    }
}
