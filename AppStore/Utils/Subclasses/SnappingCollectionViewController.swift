//
//  SnappingCollectionViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-31.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SnappingCollectionViewController: UICollectionViewController {
  init() {
    super.init(collectionViewLayout: SnappingCollectionViewLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
