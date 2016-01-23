//
//  CardView.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/07/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

enum CardFace {
  case Image, Reading
}

class CardView: UIImageView {
  
  let cardNum: Int
  
  var viewOrder: Int = 1
  
  var origConstraints = [NSLayoutConstraint]()
  var displayConstraints = [NSLayoutConstraint]()
  
  private let cardImage: UIImage!
  private let readingImage: UIImage!
  var readingView: ReadingView!
  
  var currentFace: CardFace = .Image
  
  var widthMultiplierSmall: CGFloat = 0  //in comparison to screen width
  var heightMultiplierSmall: CGFloat = 0 // in comparison to card width
  
  // MARK: - Initial set up
  
  /*
  *****************************************
  * Initialiser
  ******************************************
  */
  required init(coder aDecoder: NSCoder) {
    fatalError("use init(cardNum:)")
  }
  
  /*
  *****************************************
  * Initialiser
  ******************************************
  */
  init(cardNum: Int) {
    
    self.cardNum = cardNum
    self.cardImage = UIImage(named: "card \(cardNum)")
    self.readingImage = self.cardImage  // currently, using same image
    
    super.init(image: cardImage)

    (self.widthMultiplierSmall, self.heightMultiplierSmall) = setMultipliers()
    
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    let x: CGFloat
    let y: CGFloat
    (x, y, cardWidth, cardHeight) = calcFrame()
    
    self.frame = CGRect(x: x, y: y, width: cardWidth, height: cardHeight)
    
    //self.contentMode = UIViewContentMode.ScaleAspectFit
    
    
    self.tag = cardNum
    self.userInteractionEnabled = true
    self.layer.masksToBounds = true
    
    // must have following line if using auto layout constraints - otherwise - must comment it out
    self.translatesAutoresizingMaskIntoConstraints = false
    
    // display as circles
    setCorners()
    
  }
  
  
  /*
  *****************************************
  * Set multipliers
  ******************************************
  */
  func setMultipliers() -> (widthMultiplier: CGFloat, heightMultiplier: CGFloat) {
    let widthMultiplier = CardWidthCircle
    let heightMultiplier = CardHeightCircle
    return (widthMultiplier, heightMultiplier)
  }
 
  /*
  *****************************************
  * Calculate frame attributes
  ******************************************
  */
  func calcFrame() -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
    let width = ScreenWidth * CardWidthCircle
    let height = width * CardHeightCircle
    let x = (ScreenWidth  / 2) - (width / 2)
    let y = ScreenHeight  / 2
    return (x, y, width, height)
  }
  
  /*
  *****************************************
  * Set corners
  ******************************************
  */
  func setCorners() {
    self.layer.cornerRadius = self.frame.size.width/2
    self.clipsToBounds = true
  }

  // MARK: - Swap card face
  
  /*
  *****************************************
  * Set Reading View
  ******************************************
  */
  
  func setReadingView() {
    
    if readingView == nil {
      readingView = ReadingView(cardNum: cardNum, frame: self.bounds)
      readingView.hidden = true
      addSubview(readingView)
      readingView.setConstraints()
      //readingView.scrollRangeToVisible(NSMakeRange(0, 10))
      readingView.setContentOffset(CGPointMake(0, -720), animated: false)
    }
  }
  
  /*
  *****************************************
  * Swap card face
  ******************************************
  */
  func swapCardFace() {
    
    if currentFace == .Image {

      // swap to reading view
      currentFace = .Reading
      self.image = readingImage
      // create the reading view if doesn't already exist, otherwise unhide it
      if readingView == nil {
        setReadingView()
      }
      readingView.hidden = false
      
    } else {

      currentFace = .Image
      self.image = cardImage
      readingView.hidden = true
    }
    
  }
  
  /*
  *****************************************
  * Scroll Reading to Top
  ******************************************
  */
  
  func scrollReadingToTop() {
    readingView?.setContentOffset(CGPointMake(0, -720), animated: false)
  }
  
  // MARK: - Constraints - move to starting point
  
  /*
  *****************************************
  * Move to starting point at centre of superview
  ******************************************
  */
  func moveToCentre(xConst: CGFloat, yConst: CGFloat) {
    
    NSLayoutConstraint.deactivateConstraints(displayConstraints)
    
    if origConstraints.count > 0 {

      NSLayoutConstraint.activateConstraints(origConstraints)
    } else {
    
      let conX = NSLayoutConstraint(
        item: self,
        attribute: .CenterX,
        relatedBy: .Equal,
        toItem: self.superview!,
        attribute: .CenterX,
        multiplier: 1.0,
        constant: xConst)
      conX.identifier = "x"
      conX.active = true
      origConstraints.append(conX)
    
      let conY = NSLayoutConstraint(
        item: self,
        attribute: .CenterY,
        relatedBy: .Equal,
        toItem: self.superview!,
        attribute: .CenterY,
        multiplier: 1.0,
        constant: yConst)
      conY.identifier = "y"
      conY.active = true
      origConstraints.append(conY)

      // set width to a percentage of the screen width
      let conWidth = NSLayoutConstraint(
        item: self,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: self.superview,
        attribute: .Width,
        multiplier: widthMultiplierSmall,
        constant: 0.0)
      conWidth.active = true
      conWidth.identifier = "w"
      origConstraints.append(conWidth)
      
      // set height - to around 1.33 of the width of self
      let conHeight = NSLayoutConstraint(
        item: self,
        attribute: .Height,
        relatedBy: .Equal,
        toItem: self,
        attribute: .Width,
        multiplier: heightMultiplierSmall,
        constant: 0.0)
      conHeight.active = true
      conHeight.identifier = "h"
      origConstraints.append(conHeight)
    }
  }
  
  // MARK: - Additional functions for bouncing cards
  
  /*
  ******************************************
  * Start Move to Starting Point
  ******************************************
  */
  func startMoveToStartingPoint(xConst: CGFloat, yConst: CGFloat) {
    
    NSLayoutConstraint.deactivateConstraints(displayConstraints)
    
    if origConstraints.count > 0 {
      NSLayoutConstraint.activateConstraints(origConstraints)
    } else {
      let conX = NSLayoutConstraint(
        item: self,
        attribute: .Leading,
        relatedBy: .Equal,
        toItem: self.superview,
        attribute: .Leading,
        multiplier: 1.0,
        constant: xConst)
      conX.active = true
      conX.identifier = "x"
      origConstraints.append(conX)
      
      // set the bottom of the image to match the bottom of the view
      let conY = NSLayoutConstraint(
        item: self,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: self.superview,
        attribute: .Bottom,
        multiplier: 1.0,
        constant: yConst)
      conY.active = true
      conY.identifier = "y"
      origConstraints.append(conY)
      
      // set width to percentage of the screen width
      let conWidth = NSLayoutConstraint(
        item: self,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: self.superview,
        attribute: .Width,
        multiplier: widthMultiplierSmall,
        constant: 0.0)
      conWidth.active = true
      conWidth.identifier = "w"
      origConstraints.append(conWidth)
      
      // set height - to 1 1/3 of the width of self
      let conHeight = NSLayoutConstraint(
        item: self,
        attribute: .Height,
        relatedBy: .Equal,
        toItem: self,
        attribute: .Width,
        multiplier: heightMultiplierSmall,
        constant: 0.0)
      conHeight.active = true
      conHeight.identifier = "h"
      origConstraints.append(conHeight)
      
    }
    
  }
  
  /*
  ******************************************
  * Finish move to starting point
  ******************************************
  */
  func finishMoveToStartingPoint() {
    // move up the 250 points and make correct width
    for constraint in origConstraints {
      if constraint.identifier == "y" {
        constraint.constant += 250
      } else if constraint.identifier == "w" {
        constraint.constant = 0.0
      }
    }
    self.transform = CGAffineTransformIdentity
    self.setCorners()
    self.randomiseRotation()
    
  }
  
  
  /*
  ******************************************
  * Randomise rotation
  ******************************************
  */
  func randomiseRotation() {
    // randomly rotate the card - anywhere between -0.2 and 0.3 radians
    let rotation = CGFloat(randomNumber(0, max: 50)) / 100.0 - 0.2
    self.transform = CGAffineTransformMakeRotation(rotation)
  }
  
  
  // MARK: - Move card up and down
  
  /*
  *****************************************
  * Move up to display
  ******************************************
  */
  func moveUpToDisplay() {
    
    self.layer.cornerRadius = 5.0
    
    // straighten the card
    self.transform = CGAffineTransformIdentity
    
    NSLayoutConstraint.deactivateConstraints(origConstraints)
    
    // Move the card up and make it larger - via constraints
    if displayConstraints.count > 0 {
      NSLayoutConstraint.activateConstraints(displayConstraints)
    } else {
      createDisplayConstraints()
    }
  
  }
  
  /*
  *****************************************
  * Create display constraints
  ******************************************
  */
  func createDisplayConstraints() {
    if superview == nil {
      print("no superview for card no \(self.cardNum)")
      return
    }
    let newConstraintY = NSLayoutConstraint(
      item: self,
      attribute: .CenterY,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .CenterY,
      multiplier: 1.0,
      constant: -5.0)
    newConstraintY.identifier = "y"
    newConstraintY.active = true
    displayConstraints.append(newConstraintY)
    
    let newConstraintX = NSLayoutConstraint(
      item: self,
      attribute: .CenterX,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .CenterX,
      multiplier: 1.0,
      constant: 0.0)
    newConstraintX.identifier = "x"
    newConstraintX.active = true
    displayConstraints.append(newConstraintX)
    
    let newConstraintWidth = NSLayoutConstraint(
      item: self,
      attribute: .Width,
      relatedBy: .Equal,
      toItem: self.superview!,
      attribute: .Width,
      multiplier: CardWidthLarge,
      constant: 0.0)
    newConstraintWidth.identifier = "w"
    newConstraintWidth.active = true
    displayConstraints.append(newConstraintWidth)
    
    
    let newConstraintHeight = NSLayoutConstraint(
      item: self,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Width,
      multiplier: CardHeightLarge,
      constant: 0.0)
    newConstraintHeight.identifier = "h"
    newConstraintHeight.active = true
    displayConstraints.append(newConstraintHeight)
    
  }

  
  /*
  *****************************************
  * Move back down
  ******************************************
  */
  func moveBackDown() {
    
    NSLayoutConstraint.deactivateConstraints(displayConstraints)
    NSLayoutConstraint.activateConstraints(origConstraints)
    
    //transform = CGAffineTransformMakeRotation(self.rotation)
    
  }
  
  
}
