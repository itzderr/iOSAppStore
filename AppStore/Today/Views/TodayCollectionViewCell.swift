//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {
  let cellImageView = UIImageView(image: #imageLiteral(resourceName: "demoCell"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.cornerRadius = 16
    contentView.clipsToBounds = true
    
    contentView.addSubview(cellImageView)
    cellImageView.contentMode = .scaleAspectFill
    cellImageView.matchParent()
    setShadow()
  }
  
  private func setShadow() {
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.0)
    layer.shadowRadius = 16
    layer.shadowOpacity = 0.5
    layer.masksToBounds = false
    
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
