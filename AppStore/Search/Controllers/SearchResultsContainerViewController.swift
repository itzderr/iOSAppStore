//
//  SearchResultsContainterViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SearchResultsContainerViewController: UIViewController {
  
  private var suggestionTableViewController: SearchSuggestionTableViewController!
  private var previousViewController: UIViewController?
  
  // MARK: - Life cycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    suggestionTableViewController = SearchSuggestionTableViewController()
    suggestionTableViewController.delegate = self
  }
  
  // MARK: - Helper Methods
  
  /// Change the child view controller for this ViewController
  /// based on the SearchState and the searchTerm
  ///
  /// - Parameters:
  ///   - searchTerm: A string for the search query.
  ///   - searchState: A state of the searching process to decide the result ViewController
  func showSearchResults(searchTerm: String, searchState: SearchState) {
    debugPrint("\(#function):", searchTerm, searchState)
    switch searchState {
    case .suggestion:
      let suggestionTV = transition(to: suggestionTableViewController, searchState: searchState) as! SearchSuggestionTableViewController
      suggestionTV.fetchSearchResultApps(searchTerm: searchTerm)
      
    case .final:
      let searchfinalCV = transition(to: SearchFinalCollectionViewController(), searchState: searchState) as! SearchFinalCollectionViewController
      searchfinalCV.fetchSearchResultApps(searchTerm: searchTerm)
      
    case .trending:
      return
    }
  }
}

// MARK: - transitions

extension SearchResultsContainerViewController {
  func transition(to viewController: UIViewController, searchState: SearchState) -> UIViewController? {
    previousViewController?.remove()
    add(viewController)
    previousViewController = viewController
    
    return viewController
  }
}

// MARK: - SearchSuggestionTableViewDelegate

extension SearchResultsContainerViewController: SearchSuggestionTableViewDelegate {
  
  /// Delegate method when user select a cell from SearchSuggestionTableViewController
  ///
  /// - Parameters:
  ///   - term: A suggestion search term user selected.
  func suggestionDidSelect(term: String) {
    showSearchResults(searchTerm: term, searchState: .final)
  }
}
