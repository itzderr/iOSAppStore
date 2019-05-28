//
//  FullScreenTableViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayFullScreenViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - constants
  
  private let cellIdentifier = "DetailsCell"
  private let headerIdentifier = "HeaderCell"
  private let padding: CGFloat = 12
  
  // MARK: - variables
  
  var todayItem: TodayItem?
  var dismissController: (() -> ())?
  
  // MARK: - view controller life cylces
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewLayout()
    setupCollectionView()
    collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
  }
  
  @objc private func handleDismiss(gesture: UIGestureRecognizer) {
    dismissController?()
  }
  
  // MARK: - Initializers
 
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(String(describing: self)) \(#function)")
  }
  
  // MARK: - helper methods
  
  private func setupCollectionViewLayout() {
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    }
  }
  
  private func setupCollectionView() {
    collectionView.backgroundColor = .white
    collectionView.layer.cornerRadius = 16
    collectionView.contentInsetAdjustmentBehavior = .never // no insets
    
    collectionView.register(TodayFullScreenDetailsCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.register(TodayFullScreenHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
  }
  
  // MARK: - Collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TodayFullScreenHeaderView
    header.todayCVCell.todayItem = todayItem
    
    return header
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TodayFullScreenDetailsCell
    
    return cell
  }
  
  // MARK: - Collection view delegate

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 400)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // TODO: change hardcoded values (also for animation)
    return .init(width: view.frame.width - 2 * padding, height: 1000)
  }
}
