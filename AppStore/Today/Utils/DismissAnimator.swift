//
//  DismissAnimator.swift
//  AppStore
//
//  Created by Derrick Park on 2019-06-11.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  // MARK: - properties
  
  private let duration = 0.5
  var originFrame: CGRect = .zero
  
  // MARK: - UIViewControllerAnimatedTransitioning
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    guard let fromView = transitionContext.view(forKey: .from) else { return }
    guard let toVC = transitionContext.viewController(forKey: .to) as? MainTabBarController else { return }
    let todayCVC = toVC.viewControllers![0] as! TodayCollectionViewController
    todayCVC.statusBarHidden = true
    todayCVC.setNeedsStatusBarAppearanceUpdate()
    containerView.backgroundColor = .clear
    let animatedContainerView = UIView()
    animatedContainerView.translatesAutoresizingMaskIntoConstraints = false
    
    containerView.addSubview(animatedContainerView)
    animatedContainerView.addSubview(fromView)
    fromView.matchParent()
    
    animatedContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    let animatedContainerTopConstraint = animatedContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
    let animatedContainerWidthConstraint = animatedContainerView.widthAnchor.constraint(equalToConstant: fromView.frame.width)
    let animatedContainerHeightConstraint = animatedContainerView.heightAnchor.constraint(equalToConstant: fromView.frame.height)
    NSLayoutConstraint.activate([animatedContainerTopConstraint, animatedContainerWidthConstraint, animatedContainerHeightConstraint])
    containerView.layoutIfNeeded()
    
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
      todayCVC.statusBarHidden = false
      todayCVC.setNeedsStatusBarAppearanceUpdate()
      fromView.transform = .identity // because of scale transformation on press
      animatedContainerTopConstraint.constant = self.originFrame.minY
      animatedContainerWidthConstraint.constant = self.originFrame.width
      animatedContainerHeightConstraint.constant = self.originFrame.height
      containerView.layoutIfNeeded()
    }) { _ in
      transitionContext.completeTransition(true)
      todayCVC.selectedCell?.isHidden = false
    }
  }
}
