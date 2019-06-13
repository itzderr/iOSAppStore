//
//  TodayCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // MARK: - Constant
  
  private let reuseIdentifier = "todayCell"
  private let itemHeight: CGFloat = 400
  private let itemSpacing: CGFloat = 24
  
  // MARK: - Variables
  
  private var todayItems = [
    TodayItem(image: UIImage(named: "Lab4Physics")!, category: "FEATURED APP", title: "Lab4Physics", description: "A Lab in Your Pocket"),
    TodayItem(image: UIImage(named: "GetYourGuide")!, category: "FEATURED APP", title: "Your Insider Travel Guide", description: "GetYourGuide helps you vacation smarter"),
  ]
  private var startFrame: CGRect! // initial cell frame
  private var selectedCell: TodayCollectionViewCell?
  
  var statusBarHidden = false
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }
  override var prefersStatusBarHidden: Bool {
    return statusBarHidden
  }
  
  // MARK: - Life cycle methodss
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
    selectedCell = collectionView.cellForItem(at: indexPath) as? TodayCollectionViewCell
    presentTodayFullScreenController(indexPath)
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.size.width - itemSpacing * 2, height: itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: itemSpacing / 2, left: 0, bottom: itemSpacing / 2, right: 0)
  }
  
  // MARK: - helper methods (animation)
  
  private func getStartingFrameOfCell(at indexPath: IndexPath) -> CGRect? {
    // selected cell
    guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
    // frame for animation -> absolute coordinates of cell
    guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return nil }
    return startFrame
  }
  
  private func presentTodayFullScreenController(_ indexPath: IndexPath) {
    let fullScreenController = TodayFullScreenViewController()
    fullScreenController.todayItem = todayItems[indexPath.item]
    fullScreenController.transitioningDelegate = self
    fullScreenController.modalPresentationStyle = .custom
    fullScreenController.modalPresentationCapturesStatusBarAppearance = true
    present(fullScreenController, animated: true, completion: nil)
  }
}

extension TodayCollectionViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transition = FillAnimator()
    transition.originFrame = selectedCell!.superview!.convert(selectedCell!.frame, to: nil)
    collectionView.isUserInteractionEnabled = false // no interaction when selecting
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transition = DismissAnimator()
    transition.originFrame = selectedCell!.superview!.convert(selectedCell!.frame, to: nil)
    collectionView.isUserInteractionEnabled = true
    return transition
  }
  
  // set modalPresentationStyle to `.custom` to use this method
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return TodayPresentationController(presentedViewController: presented, presenting: presenting)
  }
}
