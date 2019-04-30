//
//  SearchViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-25.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
  
  // MARK: - Properties
  
  private var searchResults = [ResultApp]()
  private var searchController: UISearchController!
  private var autoCompleteViewController: AutoCompleteViewController!
  
  // MARK: - Constants
  
  static let cellId = "resultCell"
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    autoCompleteViewController = AutoCompleteViewController()
    searchController = UISearchController(searchResultsController: autoCompleteViewController) // Not in IB
    searchController.searchResultsUpdater = autoCompleteViewController
    autoCompleteViewController.navigationItem.searchController = self.searchController
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchViewController.cellId)
    setupSearchBar()
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK - Helper Methods
  
  fileprivate func fetchSearchResultApps() {
    APIService.shared.fetchSearchResultApps(searchTerm: "\(searchController.searchBar.text ?? "")") { (results, err) in
      if let err = err {
        print("Failed to fetch apps: ", err)
        return
      }
      
      self.searchResults = results
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  private func setupSearchBar() {
    navigationItem.searchController = self.searchController // From iOS 11
    navigationItem.hidesSearchBarWhenScrolling = false // The default is true
    
    // Ensure that the search bar does not remain on the screen if user navigates to another view controller
    // while the UISearchController is active
    definesPresentationContext = true
    searchController.searchBar.delegate = self // Monitor when the search button is tapped.
    searchController.searchBar.placeholder = "App Store"
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }
  
  // MARK: - UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // downcasting (UICollectionViewCell -> SearchCollectionViewCell)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewController.cellId, for: indexPath) as! SearchCollectionViewCell
    
    let resultApp = searchResults[indexPath.item]
    cell.nameLabel.text = resultApp.trackName
    cell.categoryLabel.text = resultApp.primaryGenreName
    cell.ratingsLabel.text = "Ratings: \(resultApp.averageUserRating ?? 0)"
    return cell
  }
}

// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchSearchResultApps()
    searchController.isActive = false
  }
}

// MARK: - AutoCompleteViewController

fileprivate class AutoCompleteViewController: UITableViewController, UISearchResultsUpdating {
  static let cellId = "resultCell"
  private var searchTerms = [ResultApp]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .blue
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: AutoCompleteViewController.cellId)
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchTerms.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AutoCompleteViewController.cellId, for: indexPath)
    cell.textLabel?.text = "🔍 \(searchTerms[indexPath.row].trackName)"
    return cell
  }
  
  // MARK - Search Reuslts Updating
  
  func updateSearchResults(for searchController: UISearchController) {
    // search throttling
    APIService.shared.fetchSearchResultApps(searchTerm: "\(searchController.searchBar.text ?? "")") { (results, err) in
      if let err = err {
        print("Failed to fetch apps: ", err)
        return
      }
      
      self.searchTerms = results
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK - Table View delgate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedSearchTerm = searchTerms[indexPath.row].trackName
    if let searchController = navigationItem.searchController {
      searchController.isActive = true
      searchController.searchBar.text = selectedSearchTerm
      dismiss(animated: true)
    }
  }
  
}

