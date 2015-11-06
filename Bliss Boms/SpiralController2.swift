//
//  SpiralController2.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 1/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

// starts from bottom centre

import UIKit

class SpiralController2: DealController {
  
  override func deal(gameView: UIView, inout deck: [CardView]) {
    
    super.deal(gameView, deck: &deck)
    
    var counter = 0
    
    for card in deck {
      counter++
      card.viewOrder = counter
      
      card.alpha = 1
      
      gameView.addSubview(card)
      // start from centre bottom of screen with a small random offset - between -30 and 30
      let xOffset = CGFloat(randomNumber(0, max: 60) - 30)
      let yOffset = CGFloat(randomNumber(0, max: 60) - 30)
      card.moveToCentre(xOffset, yConst: (ScreenHeight/5) + yOffset)
      
      let minX = UInt32(ScreenWidth/12)
      let maxX = UInt32(ScreenWidth/6)
      
      let xIncrement = CGFloat(randomNumber(minX, max: maxX))
      let yIncrement = CGFloat(randomNumber(minX, max: maxX))
      let duration = NSTimeInterval(randomNumber(8, max: 16))
      //print("x increment: \(xIncrement), y increment: \(yIncrement), duration: \(duration)")
      
      delay(seconds: 0.1, completion: {
        self.animateCard(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
      })
    }
  }
  
  func animateCard(card: CardView, xIncrement: CGFloat, yIncrement: CGFloat, duration: NSTimeInterval) {
    
    rotateCard(card)
    
    let numSteps = 12.0
    let relativeDuration = 1/numSteps  // each step has equal duration
    
    
    UIView.animateKeyframesWithDuration(duration,
      delay: 0.0,
      options: [.Repeat, .AllowUserInteraction],
      animations: {
        
        // move right and up
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*1, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*2, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*3, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*4, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*5, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*6, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*7, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*8, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*9, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*10, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*11, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
      }, completion: nil)
  }
  
  
  
  
  func rotateCard(card: CardView) {
    UIView.animateWithDuration(6.0,
      delay: 0.0,
      options: [.CurveLinear, .AllowUserInteraction],
      animations: {
        card.transform = CGAffineTransformRotate(card.transform, CGFloat(M_PI_2))
      },
      completion: { finished in
        if finished {
          self.rotateCard(card)
        }
    })
    
  }
}
