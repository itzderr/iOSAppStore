//
//  TrendingTableViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-01.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

  // MARK: - Properties
  
  let nameLabel: UILabel = {
    let lb = UILabel(fontSize: 20, bold: false)
    lb.textColor = UIColor(red: 0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    // default height: 44
    lb.heightAnchor.constraint(equalToConstant: 44).isActive = true
    return lb
  }()
  
  // MARK: - Helper methods
  func setupStaticCell() {
    nameLabel.text = "Trending"
    nameLabel.textColor = .black
    nameLabel.font = .boldSystemFont(ofSize: 22)
  }
  
  // MARK: - Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    addSubview(nameLabel)
    nameLabel.matchParent(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
