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
  var headerApp: HeaderApp? {
    didSet {
      guard let headerApp = headerApp else { return }
      categoryLabel.text = headerApp.category
      titleLabel.text = headerApp.title
      descriptionLabel.text = headerApp.summary
      appImageView.image = UIImage(named: headerApp.posterImage)
    }
  }
  
  private let categoryLabel = UILabel(text: "WHAT TO WATCH",
                              font: .boldSystemFont(ofSize: 10),
                              textColor: .systemBlue)
  
  private let titleLabel = UILabel(text: "Sportsnet",
                           font: .systemFont(ofSize: 18),
                           textColor: .black)
  
  private let descriptionLabel = UILabel(text: "Watch the Finals live",
                                 font: .systemFont(ofSize: 18),
                                 textColor: .gray)
  
  private let appImageView: UIImageView = {
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
