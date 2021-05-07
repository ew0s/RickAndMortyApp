//
//  CharacterEpisodesTableViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 06.05.2021.
//

import UIKit

class CharacterEpisodesTableViewController: UITableViewController {
    
    // MARK: - Public properties
    var characterEpisodes: [String]!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IB Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        setTableViewCell(for: cell, and: indexPath)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodeViewController else {
            return
        }
        guard let selectedRowIndex = tableView.indexPathForSelectedRow else {
            return
        }
        
        episodeVC.episodeURL = characterEpisodes[selectedRowIndex.row].description
    }
}

// MARK: - Private methods
extension CharacterEpisodesTableViewController {
    private func parseEpisode(episode: String) -> String {
        String(episode.split(separator: "/").last ?? "")
    }
    
    private func setTableViewCell(for cell: UITableViewCell, and indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        let episode = characterEpisodes[indexPath.row]
        
        configuration.text = "Episode - \(parseEpisode(episode: episode))"
        configuration.textProperties.color = .white
        configuration.textProperties.font = UIFont.boldSystemFont(ofSize: configuration.textProperties.font.pointSize)
        
        cell.contentConfiguration = configuration
        cell.backgroundColor = .black
    }
}
