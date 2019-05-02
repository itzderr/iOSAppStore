//
//  UIViewController+ChildViewControllers.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.view.matchParent()
    child.didMove(toParent: self)
  }
  
  func remove() {
    // Just to be safe, we check that this view controller
    // is actually added to a parent before removing it.
    guard parent != nil else { return }
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}

