//
//  TodayCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - Constant
  
  private let reuseIdentifier = "todayCell"
  static let cellHeight: CGFloat = 400
  static let itemSpacing: CGFloat = 24
  static let cornerRadius: CGFloat = 16
  
  // MARK: - Variables
  private var todayItems = [
    TodayItem(image: UIImage(named: "GetYourGuide")!, category: "FEATURED APP", title: "Lab4Physics", description: "A Lab in Your Pocket"),
    TodayItem(image: UIImage(named: "Lab4Physics")!, category: "FEATURED APP", title: "Your Insider Travel Guide", description: "GetYourGuide helps you vacation smarter"),
  ]
  
  var startFrame: CGRect! // initial cell frame
  var fullScreenController: TodayFullScreenViewController!
  
  // constraints animation
  var topConstraint: NSLayoutConstraint!
  var leadingConstraint: NSLayoutConstraint!
  var widthConstraint: NSLayoutConstraint!
  var heightConstraint: NSLayoutConstraint!
  
  // status bar animation
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }
  
  override var prefersStatusBarHidden: Bool {
    return statusBarHidden
  }
  
  var statusBarHidden = false
  
  // MARK: - Life cycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
  }
  
  // MARK: - Initializers
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Collection view data source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return todayItems.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCollectionViewCell
    cell.todayItem = todayItems[indexPath.item]
    return cell
  }
  
  // MARK: - UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    fullScreenController = TodayFullScreenViewController()
    fullScreenController.todayItem = todayItems[indexPath.item]
    fullScreenController.dismissController = {
      self.removeFullScreenView()
    }
    let fullScreenView = fullScreenController.view!
    view.addSubview(fullScreenView)
    addChild(fullScreenController)
    self.collectionView.isUserInteractionEnabled = false // no interaction when selecting
    
    // selected cell
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }

    // frame for animation -> absolute coordinates of cell
    guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startFrame = startFrame
    
    // constraints animation
    fullScreenView.translatesAutoresizingMaskIntoConstraints = false
    
    topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startFrame.origin.y)
    leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startFrame.origin.x)
    widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startFrame.width)
    heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startFrame.height)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0.isActive = true })
    
    self.view.layoutIfNeeded()
    
    fullScreenView.layer.cornerRadius = TodayCollectionViewController.cornerRadius
  
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] () in
     
      self.topConstraint.constant = 0
      self.leadingConstraint.constant = 0
      self.widthConstraint.constant = self.view.frame.width
      self.heightConstraint.constant = self.view.frame.height
      
      self.statusBarHidden = !self.statusBarHidden
      self.setNeedsStatusBarAppearanceUpdate()
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
      self.view.layoutIfNeeded() // starts animation
    }, completion: nil)
  }
  
  // MARK: - helper methods (animation)
  
  func removeFullScreenView() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] in
      // when removing from the bottom, bring the collectionView back on top
      self.fullScreenController.collectionView.contentOffset = .zero
      
      self.topConstraint.constant = self.startFrame.origin.y
      self.leadingConstraint.constant = self.startFrame.origin.x
      self.widthConstraint.constant = self.startFrame.width
      self.heightConstraint.constant = self.startFrame.height
      
      // status bar animation
      self.statusBarHidden = !self.statusBarHidden
      self.setNeedsStatusBarAppearanceUpdate()
      self.tabBarController?.tabBar.transform = .identity
      self.view.layoutIfNeeded()
      
    }) { [unowned self](_) in
      self.fullScreenController.remove()
      self.fullScreenController = nil
      self.collectionView.isUserInteractionEnabled = true
    }
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.size.width - TodayCollectionViewController.itemSpacing * 2, height: TodayCollectionViewController.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return TodayCollectionViewController.itemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
  }
  
}
