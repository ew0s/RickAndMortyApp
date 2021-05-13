//
//  TableViewCell.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.makeRounded()
            characterImageView.backgroundColor = .white
        }
    }
    
    //MARK: - Public methods
    func configure(with result: Character?) {
        nameLabel.text = result?.name
        DispatchQueue.global().async {
            guard let stringURL = result?.image else { return }
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
            }
        }
    }
}
