//
//  TodayFullScreenHeaderView.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-28.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayFullScreenHeaderView: UICollectionReusableView {
  
  let todayCVCell = TodayCollectionViewCell()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(todayCVCell)
    todayCVCell.matchParent()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
