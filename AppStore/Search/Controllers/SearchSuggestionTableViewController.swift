//
//  SearchSuggestionTableViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

protocol SearchSuggestionTableViewDelegate: class {
  func suggestionDidSelect(term: String)
}

class SearchSuggestionTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  private var searchTerms = [ResultApp]()
  
  weak var delegate: SearchSuggestionTableViewDelegate?
  
  // MARK: - Constants
  
  private let cellId = "resultCell"
  
  // MARK: - Life cycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .white
    tableView.register(SearchSuggestionTableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchTerms.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchSuggestionTableViewCell
    if indexPath.row >= 0 {
      cell.nameLabel.text = "🔍  \(searchTerms[indexPath.row].trackName)"
    }
    
    return cell
  }
  
  // MARK - Table View delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedSearchTerm = searchTerms[indexPath.row].trackName
    delegate?.suggestionDidSelect(term: selectedSearchTerm)
  }
  
  func fetchSearchResultApps(searchTerm: String) {
    APIService.shared.fetchSearchResultApps(searchTerm: searchTerm) { [weak self] (results, err) in
      if let err = err {
        print("Failed to fetch apps: ", err)
        return
      }
      
      self?.searchTerms = results
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
}

