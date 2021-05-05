//
//  CharactersTableViewController.swift
//  RickAndMortyApp
//
//  Created by Егор Савковский on 05.05.2021.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var rickAndMorty: RickAndMorty?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        fetchData(from: URLS.rickAndMortyApi.rawValue)
    }
    
    // MARK: - IB Actions
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
            ? fetchData(from: rickAndMorty?.info.next ?? "")
            : fetchData(from: rickAndMorty?.info.prev ?? "")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let character = rickAndMorty?.results[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}

// MARK: - Private methods
extension CharactersTableViewController {
    private func setNavigationBar() {
        
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // navigation bar appearance
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.tableView.reloadData()
        }
    }
}
