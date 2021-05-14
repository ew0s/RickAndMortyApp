//
//  DetailedCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 06.05.2021.
//

import UIKit

class DetailedCharacterViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var characterImageView: CharacterImageView!
    @IBOutlet var characterDescriptionLabel: UILabel!
    
    // MARK: - Public properties
    var character: Character?
    var characterURL: String!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    override func viewWillLayoutSubviews() {
        characterImageView.makeRounded()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {
            return
        }
        guard let characterEpisodesVC = navigationVC.topViewController as? CharacterEpisodesTableViewController else {
            return
        }
        
        characterEpisodesVC.characterEpisodes = character?.episode
    }
}

// MARK: - Private methods
extension DetailedCharacterViewController {
    
    private func setViewController() {
        NetworkManager.shared.fetchCharacter(from: characterURL) { character in
            self.character = character
            self.title = character.name
            self.characterDescriptionLabel.text = character.description
            self.characterImageView.fetchImage(from: character.image ?? "")
        }
    }
}
