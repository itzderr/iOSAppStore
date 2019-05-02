//
//  UIView+ConvenienceInit.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-01.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(fontSize: CGFloat = 17, bold: Bool = false, text: String = "") {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    if bold {
      self.font = .boldSystemFont(ofSize: fontSize)
    }
    self.font = UIFont.init(name: "", size: fontSize)
    self.text = text
  }
}
