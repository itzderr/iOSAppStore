//
//  AppsCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - constants
  
  private final let cellIdentifier = "AppsHeaderCell"
  private final let headerIdentifier = "AppsGroupCell"
  private final let itemHeight: CGFloat = 300
  
  private let indicatorView: UIActivityIndicatorView = {
    let i = UIActivityIndicatorView(style: .whiteLarge)
    i.color = .black
    i.hidesWhenStopped = true
    i.startAnimating()
    return i
  }()
  
  // MARK: - Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    collectionView.register(AppsHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    collectionView.register(AppsGroupCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    
    view.addSubview(indicatorView)
    indicatorView.matchParent()
    fetchAppGroups()
  }
  
  private var appGroups = [AppGroup]()
  
  private func fetchAppGroups() {
    var appGroupPopular: AppGroup?
    var appGroupTopFree: AppGroup?
    var appGroupTopPaid: AppGroup?
    
    // DispatchGroup: helps you to sync your data response
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    APIService.shared.fetchAppGroup(url: APIEndPoint.popularAppsGames) { (appGroup: AppGroup?, error) in
      if let err = error {
        print("Error fetching apps:", err)
        return
      }
      appGroupPopular = appGroup
      dispatchGroup.leave() // completed
    }
    
    dispatchGroup.enter()
    APIService.shared.fetchAppGroup(url: APIEndPoint.topFreeApps) { (appGroup: AppGroup?, error) in
      if let err = error {
        print("Error fetching apps:", err)
        return
      }
      appGroupTopFree = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    APIService.shared.fetchAppGroup(url: APIEndPoint.topFreeApps) { (appGroup: AppGroup?, error) in
      if let err = error {
        print("Error fetching apps:", err)
        return
      }
      appGroupTopPaid = appGroup
      dispatchGroup.leave()
    }
    
    // notify we're completely done
    dispatchGroup.notify(queue: .main) {
      self.indicatorView.stopAnimating()
      self.appGroups.append(appGroupPopular!)
      self.appGroups.append(appGroupTopFree!)
      self.appGroups.append(appGroupTopPaid!)
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroups.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AppsGroupCollectionViewCell
    let appGroup = appGroups[indexPath.item]
    cell.appGroup = appGroup
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
    
    return headerView
  }
  
  // MARK: - collection view delegate
  
  // MARK: - collection view flowlayout delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: itemHeight)
  }
  
}
