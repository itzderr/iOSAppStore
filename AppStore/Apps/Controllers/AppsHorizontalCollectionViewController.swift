//
//  AppsHorizontalCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHorizontalCollectionViewController: SnappingCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - constants
  
  private let cellIdentifier = "HorizontalAppsCell"
  private let verticalSpacing: CGFloat = 10
  private let horizontalSpacing: CGFloat = 16
  private let numRows: CGFloat = 3
  
  // MARK: - properties
  
  var appGroup: AppGroup?
  
  // MARK: - lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.decelerationRate = .fast
    collectionView.register(AppsItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.scrollDirection = .horizontal
    
  }
  
  // MARK: - CollectionView data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AppsItemCollectionViewCell
    let appResult = appGroup?.feed.results[indexPath.item]
    cell.appResult = appResult
    
    return cell
  }
  
  // MARK: - CollectionView delegate
  
  // MARK: - CollectionView flow layout delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.height - verticalSpacing * (numRows + 1)) / numRows
  
    return .init(width: view.frame.width - horizontalSpacing * 2, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return horizontalSpacing / 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
  }
}
