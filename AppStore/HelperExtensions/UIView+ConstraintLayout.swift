//
//  UIView+ConstraintLayout.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-29.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UIView {
  
  func matchParent(padding: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    if let superTopAnchor = superview?.topAnchor {
      self.topAnchor.constraint(equalTo: superTopAnchor, constant: padding.top).isActive = true
    }
    if let superBottomAnchor = superview?.bottomAnchor {
      self.bottomAnchor.constraint(equalTo: superBottomAnchor, constant: -padding.bottom).isActive = true
    }
    if let superLeadingAnchor = superview?.leadingAnchor {
      self.leadingAnchor.constraint(equalTo: superLeadingAnchor, constant: padding.left).isActive = true
    }
    if let superTrailingAnchor = superview?.trailingAnchor {
      self.trailingAnchor.constraint(equalTo: superTrailingAnchor, constant: -padding.right).isActive = true
    }
  }
}
