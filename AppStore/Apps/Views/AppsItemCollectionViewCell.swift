//
//  AppsItemCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class AppsItemCollectionViewCell: UICollectionViewCell {
  
  // MARK: - properties
  
  var appResult: AppResult! {
    didSet {
      appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
      appTitleLabel.text = appResult.name
      categoryLabel.text = appResult.artistName
    }
  }
  
  private let appIconImageView: UIImageView = {
    let iv = UIImageView(cornerRadius: 16)
    iv.backgroundColor = UIColor.brown
    iv.constraintWidth(equalToConstant: 64)
    iv.constraintHeight(equalToConstant: 64)
    return iv
  }()
  
  private let appTitleLabel = UILabel(text: "AppName",
                              font: .systemFont(ofSize: 20),
                              textColor: .black)
  
  private let categoryLabel = UILabel(text: "Entertainment",
                              font: .systemFont(ofSize: 12),
                              textColor: .gray)
  
  private let getButton: UIButton = UIButton.appleGetButton()
  
  // MARK: - initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let vStackView = VerticalStackView(arrangedSubviews: [
      appTitleLabel,
      categoryLabel
      ])
    
    let hStackView = HorizontalStackView(arrangedSubviews: [appIconImageView, vStackView, getButton],
                                         spacing: 16,
                                         alignment: .center)
    
    addSubview(hStackView)
    hStackView.matchParent(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
