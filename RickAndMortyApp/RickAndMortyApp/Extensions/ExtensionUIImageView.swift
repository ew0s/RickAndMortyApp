//
//  ExtensionUIImageView.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 06.05.2021.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
