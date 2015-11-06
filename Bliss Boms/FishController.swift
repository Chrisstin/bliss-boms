//
//  FishController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class FishController: DealController {
  
  override func deal(gameView: UIView, inout deck: [CardView]) {

    super.deal(gameView, deck: &deck)
    
    var counter = 0
    
    for card in deck {
      counter++
      card.viewOrder = counter
      card.alpha = 1
      
      gameView.addSubview(card)
      card.moveToCentre(0, yConst: -20)
      
      // randomly create a value between 20 and 1/2 of screen height
      let randomYOffset = CGFloat( randomNumber(20, max: UInt32(ScreenHeight * 0.35)) )
      
      // create a bezier path that defines the curve - convert to CGPath later
      
      // add random y offset so that each individual animation will be at different y
      let path = UIBezierPath()
      
      //println("random y offset: \(randomYOffset)")
      let startX = -card.frame.size.width
      let endX = ScreenWidth+card.frame.size.width
      
      let startY = (ScreenHeight * 0.15) + randomYOffset   // on 5S - 85   - 239
      let cp1Y = (ScreenHeight * 0.6) + randomYOffset     // 318          - 373    .56
      let cp2Y = (ScreenHeight * 0.05) + randomYOffset    // 28           - 110   .035
      let endY = (ScreenHeight * 0.1566) + randomYOffset   // 88           - 239
      
      //print("card: \(card.cardNum), ys: \(startY), \(cp1Y), \(cp2Y), \(endY)")
      
      path.moveToPoint(CGPoint(x: startX, y: startY))
      path.addCurveToPoint(CGPoint(x: endX, y: endY),
        controlPoint1: CGPoint(x: 136, y: cp1Y),
        controlPoint2: CGPoint(x: 178, y: cp2Y))
      
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
