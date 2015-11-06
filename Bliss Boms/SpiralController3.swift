//
//  SpiralController3.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 10/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

// Parabola - anti clockwise

import UIKit

class SpiralController3: DealController {
  
  override func deal(gameView: UIView, inout deck: [CardView]) {
    
    super.deal(gameView, deck: &deck)
    
    var counter = 1
    
    for card in deck {
      card.viewOrder = counter
      counter++
      card.alpha = 1
      
      gameView.addSubview(card)
      card.moveToCentre(0, yConst: -20)
      
      // parabola
      
      // randomly create a value between 20 and 1/2 of screen height
      let randomXOffset = CGFloat( randomNumber(0, max: UInt32(ScreenWidth / 5)) ) - (ScreenWidth / 10)
      let randomYOffset = CGFloat( randomNumber(0, max: UInt32(ScreenHeight / 5)) ) - (ScreenHeight / 10)
      print("xOffset: \(randomXOffset), yOffset: \(randomYOffset)")
      
      // create a bezier path that defines the curve - convert to CGPath later
      
      // for every y value on the bezier curve
      // add random y offset so that each individual animation
      // will appear at a different y position
      let path = UIBezierPath()
      
      let startX = CGFloat(230)
      //let cp1X = (ScreenWidth) + (randomXOffset * 2)
      let cp1X = 470 + randomXOffset
      //let cp2X = (randomXOffset * 2)
      let cp2X = 70 + randomXOffset
      let endX = -card.frame.size.width  + (3 * randomXOffset)     //ScreenWidth+card.frame.size.width
      
      let startY = ScreenHeight //+ card.frame.size.height //(ScreenHeight * 0.8) + randomYOffset
      //let cp1Y = randomYOffset //(ScreenHeight * 0.1) + randomYOffset
      let cp1Y = 220 + randomYOffset
      //let cp2Y = randomYOffset //(ScreenHeight * 0.1) + randomYOffset
      let cp2Y = -100 + randomYOffset
      let endY = startY + randomYOffset
      
      //print("card: \(card.cardNum), x's: \(startX), \(cp1X), \(cp2X), \(endX)")
      //print("card: \(card.cardNum), y's: \(startY), \(cp1Y), \(cp2Y), \(endY)")
      
      path.moveToPoint(CGPoint(x: startX, y: startY))
      path.addCurveToPoint(CGPoint(x: endX, y: endY),
        controlPoint1: CGPoint(x: cp1X, y: cp1Y),
        controlPoint2: CGPoint(x: cp2X, y: cp2Y))
      
      // create animation to animate the object's position
      let anim = CAKeyframeAnimation(keyPath: "position")
      // set the animation's path to our bezier curve
      anim.path = path.CGPath
      
      // rotate so that it's parallel to whatever point it is currently on the curve
      anim.rotationMode = kCAAnimationRotateAuto
      anim.repeatCount = Float.infinity
      // each square will take between 4 and 8 seconds to complete one loop
      anim.duration = Double(arc4random_uniform(40)+30) / 4
      //println(anim.duration)
      // stagger each animation by a random value
      anim.timeOffset = Double(arc4random_uniform(290))
      
      // add the animation to the card's layer property
      card.layer.addAnimation(anim, forKey: "animate position along path")
      //println("card finishes at: \(NSStringFromCGRect(card.frame))")
      
      
    }
    
  }
  
  
  
}
