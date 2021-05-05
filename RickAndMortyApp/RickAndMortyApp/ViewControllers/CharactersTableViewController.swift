//
//  CharactersTableViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

// MARK: - Private methods
extension CharactersTableViewController {
    private func setViewController() {
        tableView.rowHeight = 80
    }
}
