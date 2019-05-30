//
//  AppsItemCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsItemCollectionViewCell: UICollectionViewCell {
  
  let appIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = UIColor.brown
    iv.constraintWidth(equalToConstant: 64)
    iv.constraintHeight(equalToConstant: 64)
    iv.layer.cornerRadius = 16
    iv.clipsToBounds = true
    
    return iv
  }()
  
  let appTitleLabel = UILabel(text: "AppName", font: .systemFont(ofSize: 20), textColor: .black)
  
  let categoryLabel = UILabel(text: "Entertainment", font: .systemFont(ofSize: 12), textColor: .gray)
  
  let getButton: UIButton = UIButton.getButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let vStackView = UIStackView(arrangedSubviews: [appTitleLabel, categoryLabel])
    vStackView.axis = .vertical
    
    let hStackView = UIStackView(arrangedSubviews: [
      appIconImageView,
      vStackView,
      getButton
      ])
    hStackView.alignment = .center
    hStackView.spacing = 16
    
    addSubview(hStackView)
    hStackView.matchParent()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
