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
    
    let initialFrame = UIScreen.main.bounds
    let finalFrame = originFrame
    
    let xScaleFactor = finalFrame.width / initialFrame.width
    let yScaleFactor = finalFrame.height / initialFrame.height
    
    containerView.backgroundColor = .clear
    containerView.addSubview(fromView)
    
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
      todayCVC.statusBarHidden = false
      todayCVC.setNeedsStatusBarAppearanceUpdate()
      fromView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      fromView.layer.cornerRadius = 16 * 2
      
    }) { _ in
      transitionContext.completeTransition(true)
    }
  }
}
