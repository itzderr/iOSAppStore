//
//  StaticHeaderLayout.swift
//  AppStore
//
//  Created by Derrick Park on 2019-06-07.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class StaticHeaderLayout: UICollectionViewFlowLayout {
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    layoutAttributes?.forEach({ (attributes) in
      if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
        guard let collectionView = collectionView else { return }
        let contentOffsetY = collectionView.contentOffset.y
        
        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: collectionView.frame.width, height: attributes.frame.height)
      }
    })
    
    return layoutAttributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
