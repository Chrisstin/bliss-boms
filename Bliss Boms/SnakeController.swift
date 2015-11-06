//
//  SnakeController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class SnakeController: DealController {
  
  var gameView: UIView!
  var deck = [CardView]()
  var continueDealing = true
  
  // MARK: - Deal
  
  /*
  *****************************************
  * Deal
  ******************************************
  */
  override func deal(gameView: UIView, inout deck: [CardView]) {
    super.deal(gameView, deck: &deck)
    
    self.gameView = gameView
    self.deck = deck
    continueDealing = true
    
    for i in 0..<deck.count {
      let secs: Double = 0 + (Double(i) * 0.1)
      delay(seconds: secs, completion: { () -> () in
        self.dealCard(i)
      })
    }
  }
  
  /*
  *****************************************
  * Deal Card
  ******************************************
  */
  func dealCard(i: Int) {
    
    if continueDealing == false || i >= NumCards {
      return
    }
    
    let card = deck[i]
    card.alpha = 1.0
    card.viewOrder = i
    gameView.addSubview(card)
    
    let xConst :CGFloat = determineX(i)
    let yConst = determineY(i)
    //print("card: \(i), card num: \(card.cardNum), x const: \(xConst), y const: \(yConst)")
    
    card.startMoveToStartingPoint(xConst, yConst: yConst)
    self.gameView.layoutIfNeeded()
    
    // animate some changes
    UIView.animateWithDuration(3.0,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0.2,
      options: [.Repeat, .AllowUserInteraction],
      animations: {
        card.finishMoveToStartingPoint()
        self.gameView.layoutIfNeeded()
      }, completion: nil)
    
  }
  
  /*
  *****************************************
  * Stop Dealing
  ******************************************
  */
  
  override func stopDealing() {
    continueDealing = false
  }
  
  
  // MARK: - X and Y
  
  /*
  *****************************************
  * Determine X constant - for the x constraint
  ******************************************
  */
  func determineX(cardNum: Int) -> CGFloat {
    
    // spread evenly across the screen - using up 70% of the screen
    let realEstate = ScreenWidth * 0.7
    let xConstant = (realEstate/(CGFloat)(NumCards) * (CGFloat)(cardNum))
    
    return xConstant
  }
  
  
  /*
  *****************************************
  * Determine Y constant
  ******************************************
  */
  
  func determineY(cardNum: Int) -> CGFloat {
    
    let topY :CGFloat = (ScreenHeight / 2) + 50
    let totalSpace = ScreenHeight * 0.40
    let spacePerCard = (totalSpace / CGFloat(NumCards))
    let multiplier = CGFloat(cardNum)
    var yConstant = (topY - (spacePerCard * multiplier)) * -1
    
    // deduct 250 from y, this will be animated back in when card is dropped
    yConstant -= 250
    
    return yConstant
  }
  
  
}


