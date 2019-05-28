//
//  TodayFullScreenDetailsCell.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-27.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayFullScreenDetailsCell: UICollectionViewCell {
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    let attributedText = NSMutableAttributedString(string: "Learning about science can always be more fun.", attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 18) ])
    
    attributedText.append(NSAttributedString(string: " That was the idea that Komal Dadlani, CEO and co-founder of the Chilean studio Lab4U had in mind when studying biochemistry at the University of Chile.\n\n\"You cannot learn to ride a bicycle by reading a book, you have to live the experience and ride the bicycle. The same happens with science,\" she says.\n\nThe solution? Leverage the built-in features of the iPhone and iPad to enable teachers to improve their physics lessons through experiments. The accelerometer, microphone and camera are features often used by games and photography apps, but they're also really useful in science education\n\n Do you want to figure out the difference between distance and displacement? Jump on the \"You've Got the Moves\" experiment. Just start walking with your device and the Lab4Physics app will build a reference system that, through graphics, will show you the difference.\n\nIf you want to know what a sound wave looks like, try experiment \"So Wavy\" with Marie Curie. Whistle close to the speaker and you'll see the sound's shape in an amptitude vs. time graphic.\n\nThere are multiple experiments for you to discover the principles of physics, beyond the books. Just a little warning: the activities are designed for children over 13. For teachers, the app includes support materials designed to bring the app's experiments into their classes. \"Talent is universal, but not the opportunities. We want to democratize science by enabling both teachers and students to have a laboratory in their pockets,\" says Dadlani.", attributes: [.foregroundColor: UIColor.gray]))
    
    label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    label.attributedText = attributedText
    label.numberOfLines = 0 // infinite lines
  
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(descriptionLabel)
    descriptionLabel.matchParent()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
