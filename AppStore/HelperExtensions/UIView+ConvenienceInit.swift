//
//  UIView+ConvenienceInit.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-01.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(text: String = "", font: UIFont? = nil, textColor: UIColor? = nil) {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    if let font = font {
      self.font = font
    }
    if let textColor = textColor {
      self.textColor = textColor
    }
    self.text = text
  }
}
