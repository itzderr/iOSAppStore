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
      cardView.todayItem = todayItem
    }
  }
  
  lazy var cardView = TodayCardView(frame: .zero)
  
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
    
    contentView.addSubview(cardView)
    cardView.matchParent()
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
