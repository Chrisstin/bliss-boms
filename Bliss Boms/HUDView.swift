//
//  HUDView.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/07/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation
import UIKit

class HUDView: UIView {
  
  var shuffleButton: UIButton!
  var dealType: UISegmentedControl?
  var tapLabel: TapLabelView?
  
  required init(coder aDecoder: NSCoder) {
    fatalError("use init(frame:)")
  }
  
  // MARK: - Shuffle Button
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.userInteractionEnabled = true
    
    // load Shuffle Button
    self.shuffleButton = UIButton(type: .System)
    shuffleButton.setTitle("Select Again", forState: .Normal)
    shuffleButton.frame = CGRectMake(10, 15, 160, 60)
    shuffleButton.titleLabel!.font = UIFont(name: shuffleButton.titleLabel!.font.fontName, size: 26)
    shuffleButton.alpha = 1.0
    shuffleButton.showsTouchWhenHighlighted = true
    shuffleButton.setTitleColor(Colors[.ShuffleButtonNormal], forState: .Normal)
    shuffleButton.tintColor = Colors[.ShuffleButtonImageTint]
    shuffleButton.setTitleColor(Colors[.ShuffleButtonDisabled], forState: .Disabled)
    
    configureShuffleButtonWithImage()
    
    self.addSubview(shuffleButton)

  }
  
  func configureShuffleButtonWithImage() {
    shuffleButton.setTitle("", forState: .Normal)
    let imageEdgeInsets = UIEdgeInsetsMake(0, -110, 0, 0)
    
    shuffleButton.setImage(UIImage(named: "ic_refresh_48pt")!, forState: .Normal)
    shuffleButton.imageEdgeInsets = imageEdgeInsets
  }
  func configureShuffleButtonNoImage() {
    shuffleButton.setTitle("Select Again", forState: .Normal)
    shuffleButton.setImage(nil, forState: .Normal)
  }

  
  
  // MARK: - Deal Control
  
  func loadDealTypeControl(bgColor: UIColor, tintColor: UIColor) {
    let dealTypes = ["Swirl", "Fish", "Snake"]
    dealType = UISegmentedControl(items: dealTypes)
    dealType!.selectedSegmentIndex = 0
    dealType!.layer.cornerRadius = 5.0
    dealType!.backgroundColor = bgColor
    dealType!.tintColor = tintColor
    
    addSubview(dealType!)
    
    dealType!.translatesAutoresizingMaskIntoConstraints = false
    
    setDealTypeConstraints()
    
  }
  
  func setDealTypeConstraints() {
    
    let constraintL = NSLayoutConstraint(
      item: dealType!,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Leading,
      multiplier: 1.0,
      constant: 0)
    constraintL.active = true
    
    let constraintB = NSLayoutConstraint(
      item: dealType!,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Bottom,
      multiplier: 1.0,
      constant: -50.0)
    constraintB.active = true
    
    let constraintWidth = NSLayoutConstraint(
      item: dealType!,
      attribute: .Width,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Width,
      multiplier: 1,
      constant: 0)
    constraintWidth.active = true
    
    let constraintHeight = NSLayoutConstraint(
      item: dealType!,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1,
      constant: 44.0)
    constraintHeight.active = true
    
  }
  
  // MARK: - Hit test
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    // let touches through and only catch the ones on buttons
    
    // call the super's implementation to get which view would normally handle the touch
    let hitView = super.hitTest(point, withEvent: event)
    
    if hitView is UIButton || hitView is UISegmentedControl {
      // forward the touch to the button
      return hitView
    }
    
    // not a button, return nil which will forward the touch to the underlaying game elements layer
    return nil
  }
  
}
