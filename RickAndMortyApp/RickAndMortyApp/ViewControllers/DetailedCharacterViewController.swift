//
//  DetailedCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 06.05.2021.
//

import UIKit

class DetailedCharacterViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterDescriptionLabel: UILabel!
    @IBOutlet var viewActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var character: Character?
    var characterURL: String!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewActivityIndicator = showSpinner(in: view)
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
            
            guard let imageData = NetworkImageManager.shared.fetchImage(from: character.image) else {
                return
            }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
                self.viewActivityIndicator.stopAnimating()
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
