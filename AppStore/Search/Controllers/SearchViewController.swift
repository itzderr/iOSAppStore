//
//  SearchViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-25.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

enum SearchState {
  case trending
  case suggestion
  case final
}

// Trending Page
class SearchViewController: UITableViewController {
  
  // MARK: - Properties
  
  private var searchController: UISearchController!
  private var searchResultsContainerViewController = SearchResultsContainerViewController()
  private var searchState: SearchState = .trending
  private var timer: Timer?
  
  // MARK: - Constants
  
  private let cellId = "trendingCell"
  private let trendings = ["Instagram", "Facebook", "Tinder", "Snapchat", "Google"]
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchController = UISearchController(searchResultsController: searchResultsContainerViewController) // Not in IB
    searchController.searchResultsUpdater = self
    setupSearchBar()
    
    tableView.register(SearchTrendingTableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - Helper Methods
  
  private func setupSearchBar() {
    navigationItem.searchController = self.searchController // From iOS 11
    navigationItem.hidesSearchBarWhenScrolling = false // The default is true
    
    // Ensure that the search bar does not remain on the screen if user navigates to another view controller
    // while the UISearchController is active
    definesPresentationContext = true
    searchController.delegate = self
    searchController.searchBar.delegate = self // Monitor when the search button is tapped.
    searchController.searchBar.placeholder = "App Store"
    searchController.searchBar.autocapitalizationType = .none
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trendings.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let staticCell = SearchTrendingTableViewCell()
      staticCell.setupStaticCell()
      return staticCell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchTrendingTableViewCell
      cell.nameLabel.text = trendings[indexPath.row]
      return cell
    }
  }
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    
    guard let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty else {
      searchState = .trending
      return
    }
    // throttling
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { [unowned self] (_) in
      self.searchResultsContainerViewController.showSearchResults(searchTerm: searchTerm, searchState: self.searchState)
    })
  }
}

// MARK: - Search Bar Delegate

extension SearchViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchState = searchText.isEmpty ? .trending : .suggestion
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty else { return }
    searchResultsContainerViewController.showSearchResults(searchTerm: searchTerm, searchState: .final)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchResultsContainerViewController.showSearchResults(searchTerm: "", searchState: .suggestion)
    searchBar.resignFirstResponder()
  }
}

// MARK: - Search Controller delegate

extension SearchViewController: UISearchControllerDelegate {
  
  func presentSearchController(_ searchController: UISearchController) {
//    debugPrint("\(#function)")
  }
  
  func willPresentSearchController(_ searchController: UISearchController) {
//    debugPrint("\(#function)")
  }
  
  func didPresentSearchController(_ searchController: UISearchController) {
//    debugPrint("\(#function)")
  }
  
  func willDismissSearchController(_ searchController: UISearchController) {
//    debugPrint("\(#function)")
  }
  
  func didDismissSearchController(_ searchController: UISearchController) {
//    debugPrint("\(#function)")
  }
}
