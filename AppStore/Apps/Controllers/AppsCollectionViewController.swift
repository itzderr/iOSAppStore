//
//  AppsCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    collectionView.register(AppsHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }

  // MARK: - collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AppsGroupCollectionViewCell
    
    return cell
  }
  
  // MARK: - collection view delegate
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
    
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  // MARK: - collection view flowlayout delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
}
