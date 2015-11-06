//
//  CardViewRectangle.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 25/08/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class CardViewRectangle: CardView {
  
  
  // MARK: - overridden functions
  
  /*
  *****************************************
  * Set multipliers
  ******************************************
  */
  override func setMultipliers() -> (widthMultiplier: CGFloat, heightMultiplier: CGFloat) {
    let widthMultiplier = CardWidthRectangle
    let heightMultiplier = CardHeightRectangle
    return (widthMultiplier, heightMultiplier)
  }
  
  /*
  *****************************************
  * Calculate frame attributes
  ******************************************
  */
  override func calcFrame() -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
    let width = ScreenWidth * CardWidthCircle
    let height = width * CardHeightCircle
    let x = (ScreenWidth - width) / 2
    let y = ((ScreenHeight - height) / 2) - 20
    return (x, y, width, height)
  }
  
  /*
  *****************************************
  * Set corners
  ******************************************
  */
  override func setCorners() {
    self.layer.cornerRadius = 5.0
  }
  
  
  
}
