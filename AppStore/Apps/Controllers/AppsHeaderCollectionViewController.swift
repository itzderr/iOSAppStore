//
//  AppsHeaderCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHeaderCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - constants
  
  private final let horizontalSpacing: CGFloat = 16
  
  // MARK: - life cycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.scrollDirection = .horizontal
    
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "headerCell")
  }
  
  // MARK: - collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! AppsHeaderCollectionViewCell
    
    return cell
  }
  // MARK: - collection view delegate
  
  // MARK: - collection view flow layout delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - horizontalSpacing * 2, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: horizontalSpacing, bottom: 0, right: horizontalSpacing)
  }
 
}
