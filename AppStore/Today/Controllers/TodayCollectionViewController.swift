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
  
  private final let reuseIdentifier = "todayCell"
  private final let itemHeight: CGFloat = 400
  private final let itemSpacing: CGFloat = 24
  private final let cornerRadius: CGFloat = 16
  
  // MARK: - Variables
  
  private var todayItems = [
    TodayItem(image: UIImage(named: "Lab4Physics")!, category: "FEATURED APP", title: "Lab4Physics", description: "A Lab in Your Pocket"),
    TodayItem(image: UIImage(named: "GetYourGuide")!, category: "FEATURED APP", title: "Your Insider Travel Guide", description: "GetYourGuide helps you vacation smarter"),
  ]
  private var startFrame: CGRect! // initial cell frame
  private var fullScreenController: TodayFullScreenViewController!
  private var cellConstraints: AnchoredConstraints! // constraints for animation
  
  // blur background visual effect
  private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
  
  // status bar animation
  private var statusBarHidden = false
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }
  
  override var prefersStatusBarHidden: Bool {
    return statusBarHidden
  }
  
  // MARK: - Life cycle methodss
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(blurVisualEffectView)
    blurVisualEffectView.matchParent()
    blurVisualEffectView.alpha = 0
    
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
    
    setupTodayFullScreenController(indexPath)
    showTodayFullScreenViewController()
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
  
  private func setupTodayFullScreenController(_ indexPath: IndexPath) {
    fullScreenController = TodayFullScreenViewController()
    
    fullScreenController.todayItem = todayItems[indexPath.item]
    fullScreenController.dismissController = {
      self.removeFullScreenView()
    }
    
    let fullScreenView = fullScreenController.view!
    fullScreenView.translatesAutoresizingMaskIntoConstraints = false
    fullScreenView.layer.cornerRadius = cornerRadius
    view.addSubview(fullScreenView)
    addChild(fullScreenController)
    
    collectionView.isUserInteractionEnabled = false // no interaction when selecting
    startFrame = getStartingFrameOfCell(at: indexPath)
    
    // constraints animation
    cellConstraints = fullScreenView.anchors(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: startFrame.origin.y, left: startFrame.origin.x, bottom: 0, right: 0), size: .init(width: startFrame.width, height: startFrame.height))

    view.layoutIfNeeded()
    setupPanGestureRecognizer()
  }

  private func showTodayFullScreenViewController() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] in
      self.blurVisualEffectView.alpha = 1
      self.cellConstraints?.top?.constant = 0
      self.cellConstraints?.leading?.constant = 0
      self.cellConstraints?.width?.constant = self.view.frame.width
      self.cellConstraints?.height?.constant = self.view.frame.height
      
      self.statusBarHidden = !self.statusBarHidden
      self.setNeedsStatusBarAppearanceUpdate()
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
      self.view.layoutIfNeeded() // starts animation
      }, completion: nil)
  }
  
  private func removeFullScreenView() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] in
      self.blurVisualEffectView.alpha = 0
      // drag to dismiss changes transform property
      self.fullScreenController.view.transform = .identity
      // when removing from the bottom, bring the collectionView back on top
      self.fullScreenController.collectionView.contentOffset = .zero
      
      self.cellConstraints?.top?.constant = self.startFrame.origin.y
      self.cellConstraints?.leading?.constant = self.startFrame.origin.x
      self.cellConstraints?.width?.constant = self.startFrame.width
      self.cellConstraints?.height?.constant = self.startFrame.height
      
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
}

extension TodayCollectionViewController: UIGestureRecognizerDelegate {
  private func setupPanGestureRecognizer() {
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragToDismiss))
    gestureRecognizer.delegate = self
    self.fullScreenController.view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc private func dragToDismiss(gesture: UIPanGestureRecognizer) {
    let contentOffsetY: CGFloat = fullScreenController.collectionView.contentOffset.y
    // we do not want to transform when the contentOffset > 0
    // contentOffsetY == 0 when scrolled to the top
    if contentOffsetY > 0 { return }

    let translationY = gesture.translation(in: fullScreenController.view).y
    if gesture.state == .changed {
      // we do not want to transfrom when scrolling up
      if translationY > 0 {
        var scale = 1 - (translationY / 2000)  // translationY value too big
        // 0.85 <= scale <= 1
        scale = max(0.85, min(1, scale))
        fullScreenController.view.transform = CGAffineTransform(scaleX: scale, y: scale)
      }
    } else if gesture.state == .ended {
      if translationY > 200 {
        removeFullScreenView()
      } else {
        fullScreenController.view.transform = .identity
      }
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
}
