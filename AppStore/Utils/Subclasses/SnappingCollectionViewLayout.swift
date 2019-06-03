//
//  SnappingCollectionViewLayout.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-31.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    
    let contentInsetLeft: CGFloat = 16
    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let horizontalOffset = proposedContentOffset.x
    
    let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    
    let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
    layoutAttributesArray?.forEach({ (layoutAttributes) in
      let itemOffset = layoutAttributes.frame.origin.x
      if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
        offsetAdjustment = itemOffset - horizontalOffset
      }
    })
    
    return CGPoint(x: proposedContentOffset.x + offsetAdjustment - contentInsetLeft, y: proposedContentOffset.y)
  }
}
