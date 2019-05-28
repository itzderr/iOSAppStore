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

  let cellImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Lab4Physics"))
    iv.contentMode = .scaleToFill
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.heightAnchor.constraint(equalToConstant: 300).isActive = true
    return iv
  }()
  
  let categoryLabel: UILabel = {
    let lb = UILabel(fontSize: 16, bold: true)
    lb.textColor = UIColor(white: 0.5, alpha: 0.7)
    return lb
  }()
  
  let titleLabel: UILabel = {
    let lb = UILabel(fontSize: 24, bold: true)
//    lb.numberOfLines = 2 ?? 0 unlimitted lines
//    lb.lineBreakMode = .byWordWrapping
    return lb
  }()
  
  let descriptionLabel: UILabel = {
    let lb = UILabel(fontSize: 14, bold: false)
    lb.textColor = UIColor(white: 0.4, alpha: 1.0)
    return lb
  }()
  
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
    
    let labelStackView = UIStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      descriptionLabel,
      ])
    labelStackView.translatesAutoresizingMaskIntoConstraints = false
    labelStackView.axis = .vertical
    labelStackView.distribution = .equalSpacing
    
    contentView.addSubview(cellImageView)
    contentView.addSubview(labelStackView)
    
    cellImageView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: nil)
    labelStackView.anchors(topAnchor: cellImageView.bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    setShadow()
  }
  
  required init?(coder aDecodrer: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - helper methods
  
  private func setShadow() {
    // shadowing slows down the performance
    self.backgroundView = UIView()
    self.backgroundView?.matchParent()
    self.backgroundView?.backgroundColor = .white
    self.backgroundView?.layer.cornerRadius = 16
    self.backgroundView?.layer.shadowColor = UIColor.black.cgColor
    self.backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.backgroundView?.layer.shadowRadius = 16
    self.backgroundView?.layer.shadowOpacity = 0.3
    self.backgroundView?.layer.masksToBounds = false // do not want to clip the shadows
    self.backgroundView?.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

    // increase performance (scroll) - but blury when you apply on contentView's layer
    self.backgroundView?.layer.shouldRasterize = true
  }
  
}
