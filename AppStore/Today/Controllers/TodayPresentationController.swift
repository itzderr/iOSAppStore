//
//  TodayPresentationController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-06-11.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

final class TodayPresentationController: UIPresentationController {
  
  private let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  
  override var shouldRemovePresentersView: Bool {
    return false
  }
  
  override func presentationTransitionWillBegin() {
    let container = containerView!
    blurVisualEffectView.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
    container.addSubview(blurVisualEffectView)
    blurVisualEffectView.alpha = 0.0
    
    presentingViewController.beginAppearanceTransition(false, animated: false)
    presentedViewController.transitionCoordinator!.animate(alongsideTransition: { _ in
      UIView.animate(withDuration: 0.5, animations: {
        self.blurVisualEffectView.effect = UIBlurEffect(style: .light)
        self.blurVisualEffectView.alpha = 1
      })
    }) { _ in }
  }
  
  override func presentationTransitionDidEnd(_ completed: Bool) {
    presentingViewController.endAppearanceTransition()
  }
  
  override func dismissalTransitionWillBegin() {
    presentingViewController.beginAppearanceTransition(true, animated: true)
    presentedViewController.transitionCoordinator!.animate(alongsideTransition: { _ in
      self.blurVisualEffectView.alpha = 0.0
    }, completion: nil)
  }
  
  override func dismissalTransitionDidEnd(_ completed: Bool) {
    presentingViewController.endAppearanceTransition()
    if completed {
      blurVisualEffectView.removeFromSuperview()
    }
  }
}
