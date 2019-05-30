//
//  SuggestionTableViewCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-30.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SearchSuggestionTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  let nameLabel: UILabel = {
    let lb = UILabel(font: .systemFont(ofSize: 15))
    // default height: 44
    lb.constraintHeight(equalToConstant: 44)
    return lb
  }()
  
  // MARK: - Initializer
  
  override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(nameLabel)
    nameLabel.matchParent(padding: .init(top: 0, left: 8, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
