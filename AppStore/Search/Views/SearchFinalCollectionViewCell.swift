//
//  SearchCollectionViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-29.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SearchFinalCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  var resultApp: ResultApp! {
    didSet {
      nameLabel.text = resultApp.trackName
      categoryLabel.text = resultApp.primaryGenreName
      ratingsLabel.text = "Ratings: \(resultApp.averageUserRating ?? 0)"
      
      iconImageView.sd_setImage(with: URL(string: resultApp.artworkUrl100))
      screenshot1ImageView.sd_setImage(with: URL(string: resultApp.screenshotUrls[0]))
      if resultApp.screenshotUrls.count > 1 {
        screenshot2ImageView.sd_setImage(with: URL(string: resultApp.screenshotUrls[1]))
      }
      if resultApp.screenshotUrls.count > 2 {
        screenshot3ImageView.sd_setImage(with: URL(string: resultApp.screenshotUrls[2]))
      }
    }
  }
  
  let iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
    iv.layer.cornerRadius = 16
    iv.clipsToBounds = true
    return iv
  }()
  
  let nameLabel: UILabel = {
    let lb = UILabel()
    lb.text = "Instagram"
    return lb
  }()
  
  let categoryLabel: UILabel = {
    let lb = UILabel()
    lb.text = "Photos & Videos"
    return lb
  }()
  
  let ratingsLabel: UILabel = {
    let lb = UILabel()
    lb.text = "991K"
    return lb
  }()
  
  let getButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("GET", for: .normal)
    butt.setTitleColor(.systemBlue, for: .normal)
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.backgroundColor = UIColor(white: 0.95, alpha: 1)
    butt.widthAnchor.constraint(equalToConstant: 80).isActive = true
    butt.heightAnchor.constraint(equalToConstant: 32).isActive = true
    butt.layer.cornerRadius = 16
    return butt
  }()
  
  lazy var screenshot1ImageView: UIImageView = createScreenShotImageView()
  lazy var screenshot2ImageView: UIImageView = createScreenShotImageView()
  lazy var screenshot3ImageView: UIImageView = createScreenShotImageView()
  
  // MARK: - Helper methods
  
  fileprivate func createScreenShotImageView() -> UIImageView {
    let iv = UIImageView()
    iv.layer.cornerRadius = 8
    iv.clipsToBounds = true
    iv.layer.borderWidth = 0.5
    iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    iv.contentMode = .scaleAspectFill
    return iv
  }
  
  // MARK - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let labelsStackView = UIStackView(arrangedSubviews: [
      nameLabel, categoryLabel, ratingsLabel
      ])
    labelsStackView.axis = .vertical
    
    let appInfoStackView = UIStackView(arrangedSubviews: [
      iconImageView, labelsStackView, getButton
      ])
    appInfoStackView.spacing = 12
    appInfoStackView.alignment = .center
    
    let screenshotsStackView = UIStackView(arrangedSubviews: [
      screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
      ])
    screenshotsStackView.spacing = 12
    screenshotsStackView.distribution = .fillEqually
    
    let wholeStackView = UIStackView(arrangedSubviews: [
      appInfoStackView, screenshotsStackView
      ])
    wholeStackView.axis = .vertical
    wholeStackView.spacing = 16
    
    addSubview(wholeStackView)
    wholeStackView.matchParent(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

