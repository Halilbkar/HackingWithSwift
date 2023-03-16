//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Halil Bakar on 3.03.2023.
//

import UIKit

final class ViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    private var petitions: [Petition] = []
    private var filteredPetitions: [Petition] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureSearchController()
        loadData()
    }
    
    private func configureNavigationBar() {
        title = "Petitions"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Petitions"
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    private func loadData() {
        let urlString: String
        
        switch navigationController?.tabBarItem.tag {
        case 0:
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        case 1:
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        default:
            fatalError("TabBar Index Out of Range")
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                filterResults()
                return
            }
        }
        showError()
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        guard let petitions = try? decoder.decode(Petitions.self, from: json) else {
            fatalError("Unable to decode JSON file")
        }
        self.petitions = petitions.results
        tableView.reloadData()
    }
    
    private func filterResults() {
        
        guard let searchBarText = searchController.searchBar.text?.lowercased() else { return }
        
        if searchBarText.isEmpty {
            filteredPetitions = petitions
        } else {
            filteredPetitions = petitions.filter { $0.title.lowercased().contains(searchBarText)  }
        }
        tableView.reloadData()
    }
    
    private func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed: please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "This app uses the We the People API, but is neither endorsed nor certified by the White House.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - SearchBar
    
    func updateSearchResults(for searchController: UISearchController) {
        filterResults()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResults()
    }
}

