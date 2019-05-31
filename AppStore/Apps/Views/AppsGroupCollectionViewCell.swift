//
//  AppsGroupCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsGroupCollectionViewCell: UICollectionViewCell {
  
  let categoryLabel = UILabel(text: "Must-Have Apps",
                              font: .boldSystemFont(ofSize: 22),
                              textColor: .black)
  
  let seeAllButton: UIButton = {
    let b = UIButton(type: .system)
    b.translatesAutoresizingMaskIntoConstraints = false
    b.setTitle("See All", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 16)
    b.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return b
  }()
  
  let appsHorizontalController = AppsHorizontalCollectionViewController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let hStackView = HorizontalStackView(arrangedSubviews: [categoryLabel, seeAllButton])
    
    addSubview(hStackView)
    addSubview(appsHorizontalController.view)
    
    hStackView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 20))
    
    appsHorizontalController.view.anchors(topAnchor: hStackView.bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
