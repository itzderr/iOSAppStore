//
//  SearchFinalCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import SDWebImage

class SearchFinalCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - Properties
  
  private var searchResults = [ResultApp]()
  
  // MARK: - Constants
  
  private let cellId = "resultCell"
  
  // MARK: - Life cycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchFinalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("deinit")
  }
  // MARK: - Helper Methods
  
  func fetchSearchResultApps(searchTerm: String) {
    APIService.shared.fetchSearchResultApps(searchTerm: searchTerm) { (results, err) in
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchFinalCollectionViewCell
    
    cell.resultApp = searchResults[indexPath.item]
    
    
    return cell
  }
  
}
