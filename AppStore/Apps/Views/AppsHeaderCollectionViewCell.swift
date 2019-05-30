//
//  AppsHeaderCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsHeaderCollectionViewCell: UICollectionViewCell {
  let categoryLabel = UILabel(text: "WHAT TO WATCH", font: .boldSystemFont(ofSize: 10), textColor: .systemBlue)
  
  let titleLabel = UILabel(text: "Sportsnet", font: .systemFont(ofSize: 18), textColor: .black)
  
  let descriptionLabel = UILabel(text: "Watch the Finals live", font: .systemFont(ofSize: 18), textColor: .gray)
  
  let appImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.layer.cornerRadius = 8
    iv.clipsToBounds = true
    iv.backgroundColor = .green
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let vStackView = UIStackView(arrangedSubviews: [
      categoryLabel, titleLabel, descriptionLabel, appImageView
      ])
    vStackView.axis = .vertical
    vStackView.spacing = 3
    addSubview(vStackView)
    vStackView.matchParent(padding: .init(top: 8, left: 0, bottom: 0, right: 0))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
