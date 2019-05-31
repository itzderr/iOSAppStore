//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {
  
  // MARK: - variables
  
  var todayItem: TodayItem! {
    didSet {
      cellImageView.image = todayItem.image
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      descriptionLabel.text = todayItem.description
    }
  }

  private let cellImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Lab4Physics"))
    iv.contentMode = .scaleToFill
    iv.constraintHeight(equalToConstant: 300)
    return iv
  }()
  
  private let categoryLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 16),
                                               textColor: UIColor(white: 0.5, alpha: 0.7))
  
  private let titleLabel: UILabel = UILabel(font: .boldSystemFont(ofSize: 24))
  
  private let descriptionLabel: UILabel = UILabel(font: .systemFont(ofSize: 14),
                                                  textColor: UIColor(white: 0.4, alpha: 1.0))
  
  // MARK: - cell press animation
  override var isHighlighted: Bool {
    didSet {
      var transform: CGAffineTransform = .identity
      if isHighlighted {
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
      }

      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.transform = transform
      })
    }
  }
  
  // MARK: - initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 16
    contentView.clipsToBounds = true
    
    let labelStackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      descriptionLabel,
      ], spacing: 0, distribution: .equalSpacing)
    
    contentView.addSubview(cellImageView)
    contentView.addSubview(labelStackView)
    
    cellImageView.anchors(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: nil)
    labelStackView.anchors(topAnchor: cellImageView.bottomAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: contentView.bottomAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    setShadow()
  }
  
  required init?(coder aDecodrer: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - helper methods
  
  private func setShadow() {
    // shadowing slows down the performance
    backgroundView = UIView()
    backgroundView?.matchParent()
    backgroundView?.backgroundColor = .white
    backgroundView?.layer.cornerRadius = 16
    backgroundView?.layer.shadowColor = UIColor.black.cgColor
    backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 2)
    backgroundView?.layer.shadowRadius = 16
    backgroundView?.layer.shadowOpacity = 0.3
    backgroundView?.layer.masksToBounds = false // do not want to clip the shadows
    backgroundView?.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

    // increase performance (scroll) - but blury when you apply on contentView's layer
    backgroundView?.layer.shouldRasterize = true
  }
  
}
