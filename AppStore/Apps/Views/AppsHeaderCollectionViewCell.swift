//
//  AppsHeaderCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHeaderCollectionViewCell: UICollectionViewCell {
  
  // MARK: - properties
  
  let categoryLabel = UILabel(text: "WHAT TO WATCH",
                              font: .boldSystemFont(ofSize: 10),
                              textColor: .systemBlue)
  
  let titleLabel = UILabel(text: "Sportsnet",
                           font: .systemFont(ofSize: 18),
                           textColor: .black)
  
  let descriptionLabel = UILabel(text: "Watch the Finals live",
                                 font: .systemFont(ofSize: 18),
                                 textColor: .gray)
  
  let appImageView: UIImageView = {
    let iv = UIImageView(cornerRadius: 16)
    iv.backgroundColor = .green
    return iv
  }()
  
  // MARK: - initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let vStackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      descriptionLabel,
      appImageView
      ], spacing: 3)
    
    addSubview(vStackView)
    vStackView.matchParent(padding: .init(top: 8, left: 0, bottom: 0, right: 0))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
