//
//  AppsHeaderCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHeaderCollectionViewController: SnappingCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - variables
  private let headerApps = [
    HeaderApp(category: "WHAT TO WATCH", title: "Sportsnet", summary: "Watch the Finals live", posterImage: "Sportsnet"),
    HeaderApp(category: "WATCH IT LIVE", title: "DAZN Live Sports Streaming", summary: "Champoions League Final", posterImage: "DAZN"),
    HeaderApp(category: "NEW APP", title: "Poshmark", summary: "Buy and sell in Canada", posterImage: "Poshmark"),
    HeaderApp(category: "GET FIT", title: "MyFitnessPal", summary: "Meal plan like a champ", posterImage: "MyFitnessPal"),
    HeaderApp(category: "MAJOR UPDATE", title: "Ulysses", summary: "Now supporting Ghost Publishing", posterImage: "Ulysses")
  ]
  
  // MARK: - constants
  
  private let horizontalSpacing: CGFloat = 16
  
  // MARK: - life cycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.decelerationRate = .fast
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.scrollDirection = .horizontal
    
    collectionView.register(AppsHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "headerCell")
  }
  
  // MARK: - collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return headerApps.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as! AppsHeaderCollectionViewCell
    cell.headerApp = headerApps[indexPath.item]
    return cell
  }
  // MARK: - collection view delegate
  
  // MARK: - collection view flow layout delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - horizontalSpacing * 2, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return horizontalSpacing / 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: horizontalSpacing, bottom: 0, right: horizontalSpacing)
  }
 
}
