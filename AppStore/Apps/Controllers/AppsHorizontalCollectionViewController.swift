//
//  AppsHorizontalCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHorizontalCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    collectionView.register(AppsItemCollectionViewCell.self, forCellWithReuseIdentifier: "horizontal")
    
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.scrollDirection = .horizontal
    
  }
  
  // MARK: - CollectionView data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontal", for: indexPath) as! AppsItemCollectionViewCell
    
    return cell
  }
  
  // MARK: - CollectionView delegate
  
  // MARK: - CollectionView flow layout delegate
  
  final let verticalSpacing: CGFloat = 10
  final let horizontalSpacing: CGFloat = 16
  final let numRows: CGFloat = 3
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.height - verticalSpacing * (numRows + 1)) / numRows
  
    return .init(width: view.frame.width - horizontalSpacing * 2, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return verticalSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
  }
}
