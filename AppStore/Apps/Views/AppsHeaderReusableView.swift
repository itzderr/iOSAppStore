//
//  AppsHeaderReusableView.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHeaderReusableView: UICollectionReusableView {
  
  // MARK: - properties
  
  let appHeaderController = AppsHeaderCollectionViewController()
  
  // MARK: - initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(appHeaderController.view)
    appHeaderController.view.matchParent()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
