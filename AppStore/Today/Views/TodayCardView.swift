//
//  TodayCardView.swift
//  AppStore
//
//  Created by Derrick Park on 2019-06-07.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayCardView: UIView {
  
  var todayItem: TodayItem! {
    didSet {
      cellImageView.image = todayItem.image
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      descriptionLabel.text = todayItem.description
    }
  }
  
  let cellImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Lab4Physics"))
    iv.contentMode = .scaleAspectFill
    iv.constraintHeight(equalToConstant: 300)
    return iv
  }()
  
  private let categoryLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 16),
                                               textColor: UIColor(white: 0.5, alpha: 0.7))
  
  private let titleLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 24))
  
  private let descriptionLabel: UILabel = UILabel(font: .systemFont(ofSize: 14),
                                                  textColor: UIColor(white: 0.4, alpha: 1.0))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    let labelStackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      descriptionLabel,
      ], spacing: 0, distribution: .equalSpacing)
    
    addSubview(cellImageView)
    addSubview(labelStackView)
    
    cellImageView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: nil)
    labelStackView.anchors(topAnchor: cellImageView.bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
