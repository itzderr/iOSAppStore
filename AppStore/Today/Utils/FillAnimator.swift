//
//  FillAnimator.swift
//  AppStore
//
//  Created by Derrick Park on 2019-06-07.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class FillAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  // MARK: - properties
  
  private let duration = 0.5
  var originFrame: CGRect = .zero
  
  // MARK: - UIViewControllerAnimatedTransitioning

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    // TodayFullScreenController's view
    guard let toView = transitionContext.view(forKey: .to) else { return }
  
    let initialFrame = originFrame
    let finalFrame = toView.frame
    
    let xScaleFactor = initialFrame.width / finalFrame.width
    let yScaleFactor = initialFrame.height / finalFrame.height
    
    toView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
    toView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
    containerView.backgroundColor = .clear
    containerView.addSubview(toView)
    
    guard let toVC = transitionContext.viewController(forKey: .to) as? TodayFullScreenViewController else { return }
    
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
      toVC.statusBarHidden = true
      toVC.setNeedsStatusBarAppearanceUpdate()
      toView.transform = .identity
      toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      
    }) { _ in
      transitionContext.completeTransition(true)
    }
  }
  
}
