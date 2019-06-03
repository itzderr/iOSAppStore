//
//  AppsGroupCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsGroupCollectionViewCell: UICollectionViewCell {
  
  // MARK: - properties
  var appGroup: AppGroup! {
    didSet {
      categoryLabel.text = appGroup.feed.title
      appsHorizontalController.appGroup = appGroup
      appsHorizontalController.collectionView.reloadData()
    }
  }
  
  private let categoryLabel = UILabel(text: "Must-Have Apps",
                              font: .boldSystemFont(ofSize: 22),
                              textColor: .black)
  
  private let seeAllButton: UIButton = {
    let b = UIButton(type: .system)
    b.translatesAutoresizingMaskIntoConstraints = false
    b.setTitle("See All", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 16)
    b.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return b
  }()
  
  private let appsHorizontalController = AppsHorizontalCollectionViewController()
  
  private final let padding: CGFloat = 16
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let hStackView = HorizontalStackView(arrangedSubviews: [categoryLabel, seeAllButton])
    
    addSubview(hStackView)
    addSubview(appsHorizontalController.view)
    
    hStackView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: nil, padding: .init(top: padding, left: padding, bottom: 0, right: padding * 2))
    
    appsHorizontalController.view.anchors(topAnchor: hStackView.bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
