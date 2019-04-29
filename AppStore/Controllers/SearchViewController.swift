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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // downcasting (UICollectionViewCell -> SearchCollectionViewCell)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
    
    return cell
  }
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
