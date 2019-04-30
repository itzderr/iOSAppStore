//
//  SearchViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-25.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
// UICollectionViewDataSource, Delegate
class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
 
  fileprivate let cellId = "resultCell"
  fileprivate var searchResults = [ResultApp]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    
    fetchSearchResultApps()
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // downcasting (UICollectionViewCell -> SearchCollectionViewCell)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
    
    let resultApp = searchResults[indexPath.item]
    cell.nameLabel.text = resultApp.trackName
    cell.categoryLabel.text = resultApp.primaryGenreName
    cell.ratingsLabel.text = "Ratings: \(resultApp.averageUserRating ?? 0)"
    return cell
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate func fetchSearchResultApps() {
    APIService.shared.fetchSearchResultApps { (results, err) in
      
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
  
}
