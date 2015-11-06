//
//  TapLabelView.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 5/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class TapLabelView: UILabel {

  required init(coder aDecoder: NSCoder) {
    fatalError("use init(frame:")
  }
  
  
  init(frame: CGRect, textColor: UIColor) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    self.textColor = textColor
    self.text = "Tap Any Card"
    self.font = UIFont(name: self.font.fontName, size: 30)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  func setConstraints(bottomConst: CGFloat) {

    
    let constraintL = NSLayoutConstraint(
      item: self,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Leading,
      multiplier: 1.0,
      constant: 15.0)
    constraintL.active = true
    
    let constraintB = NSLayoutConstraint(
      item: self,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Bottom,
      multiplier: 1.0,
      constant: bottomConst)
    constraintB.active = true

    let constraintWidth = NSLayoutConstraint(
      item: self,
      attribute: .Width,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 200.0)
    constraintWidth.active = true
    
    let constraintHeight = NSLayoutConstraint(
      item: self,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 33.0)
    constraintHeight.active = true
    
  }

}
