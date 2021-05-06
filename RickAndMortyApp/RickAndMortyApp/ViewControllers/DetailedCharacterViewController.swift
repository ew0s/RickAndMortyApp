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
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    override func viewWillLayoutSubviews() {
        characterImageView.makeRounded()
    }
    
    // MARK: - IB Actions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Private methods
extension DetailedCharacterViewController {
    
    private func setViewController() {
        setCharacterImage()
        setDescriptionLabel()
    }
    
    private func setCharacterImage() {
        NetworkImageManager.shared.fetchImage(from: character.image) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setDescriptionLabel() {
        characterDescriptionLabel.text = character.description
    }
}
