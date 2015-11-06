//
//  SpiralController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class SpiralController: DealController {
  
  override func deal(gameView: UIView, inout deck: [CardView]) {
    
    super.deal(gameView, deck: &deck)
    
    var counter = 0
    
    for card in deck {
      counter++
      card.viewOrder = counter
      
      card.alpha = 1
      
      gameView.addSubview(card)
      card.moveToCentre(0, yConst: -20)
      
      let minX = UInt32(ScreenWidth/12)
      let maxX = UInt32(ScreenWidth/8)
      let minY = UInt32(ScreenHeight/14) - 20
      let maxY = UInt32(ScreenHeight/10) - 20
      
      let xIncrement = CGFloat(randomNumber(minX, max: maxX))
      let yIncrement = CGFloat(randomNumber(minY, max: maxY))
      let duration = NSTimeInterval(randomNumber(8, max: 24))
      //print("x increment: \(xIncrement), y increment: \(yIncrement), duration: \(duration)")
      
      delay(seconds: 0.1, completion: {
        let mod = card.cardNum % 4
        switch mod {
        case 0:
          self.animateCardFromBottom(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
        case 1:
          self.animateCardFromRight(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
        case 2:
          self.animateCardFromTop(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
        case 3:
          self.animateCardFromLeft(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
        default:
          self.animateCardFromBottom(card, xIncrement: xIncrement, yIncrement: yIncrement, duration: duration)
        }
      })
      
      
      
    }
  }
  
  func animateCardFromBottom(card: CardView, xIncrement: CGFloat, yIncrement: CGFloat, duration: NSTimeInterval) {
    
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
  
  func animateCardFromRight(card: CardView, xIncrement: CGFloat, yIncrement: CGFloat, duration: NSTimeInterval) {
    
    rotateCard(card)
    
    let numSteps = 12.0
    let relativeDuration = 1/numSteps  // each step has equal duration
    
    
    UIView.animateKeyframesWithDuration(duration,
      delay: 0.0,
      options: [.Repeat, .AllowUserInteraction],
      animations: {
        
        
        // move left and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*0, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*1, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*2, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*3, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*4, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*5, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*6, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*7, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*8, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*9, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*10, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*11, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
      }, completion: nil)
  }
  
  func animateCardFromTop(card: CardView, xIncrement: CGFloat, yIncrement: CGFloat, duration: NSTimeInterval) {
    
    rotateCard(card)
    
    let numSteps = 12.0
    let relativeDuration = 1/numSteps  // each step has equal duration
    
    
    UIView.animateKeyframesWithDuration(duration,
      delay: 0.0,
      options: [.Repeat, .AllowUserInteraction],
      animations: {
        
        
        // move left and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*0, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*1, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*2, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*3, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*4, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*5, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*6, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*7, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*8, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*9, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*10, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*11, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
      }, completion: nil)
  }
  
  func animateCardFromLeft(card: CardView, xIncrement: CGFloat, yIncrement: CGFloat, duration: NSTimeInterval) {
    
    rotateCard(card)
    
    let numSteps = 12.0
    let relativeDuration = 1/numSteps  // each step has equal duration
    
    
    UIView.animateKeyframesWithDuration(duration,
      delay: 0.0,
      options: [.Repeat, .AllowUserInteraction],
      animations: {
        
        
        // move right and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*0, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*1, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*2, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move right and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*3, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*4, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*5, relativeDuration: relativeDuration, animations: {
          card.center.x += xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and up
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*6, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*7, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*8, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y -= yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        
        // move left and down
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*9, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*10, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
          card.center.y += yIncrement
          //println("x: \(card.center.x), y: \(card.center.y)")
        })
        UIView.addKeyframeWithRelativeStartTime(relativeDuration*11, relativeDuration: relativeDuration, animations: {
          card.center.x -= xIncrement
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
