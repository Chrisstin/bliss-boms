//
//  FateController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class FateController: GameController {

  
  /*
  ******************************************
  * Create deck - Rectangular cards
  ******************************************
  */
  override func createDeck() {
      
    for cardNum in 1...NumCards {
      let card = CardViewRectangle(cardNum: cardNum)
      let recogniser = UITapGestureRecognizer(target: self, action: Selector("flipCard"))
      card.addGestureRecognizer(recogniser)
      self.deck.append(card)
    }
  }
  
  
  /*
  *****************************************
  * Initialise Game - called from view did load
  ******************************************
  */
  override func initialiseGame() {
    
    super.initialiseGame()
    
    let recogniser = UITapGestureRecognizer(target: self, action: Selector("handleDismissTap"))
    gameView.addGestureRecognizer(recogniser)
    
  }
  
  override func configureShuffleButtonImage() {
    self.hud.configureShuffleButtonNoImage()
  }
  
  /*
  *****************************************
  * Deal Deck
  ******************************************
  */
  override func dealDeck() {
      
    super.dealDeck()
      
    // ensure all cards have image displayed
    for card in deck {
      if card.currentFace == .Reading {
        card.swapCardFace()
      }
    }
      
    deck.shuffle()
    for card in deck {
      
      
      card.alpha = 1
      gameView.addSubview(card)
      card.moveToCentre(0, yConst: -20)
      
      // randomly create a value between 20 and 1/2 of screen height
      let randomYOffset = CGFloat( arc4random_uniform(250))
      
      // create a bezier path that defines the curve - convert to CGPath later
      let path = UIBezierPath()
      
      let startX = ScreenWidth / 20
      let cp1X = ScreenWidth * 0.42
      let cp2X = ScreenWidth * 0.55
      let endX = ScreenWidth * 0.94
      
      let startY = (ScreenHeight * 0.4) + randomYOffset
      let cp1Y = (ScreenHeight * 0.67) + randomYOffset
      let cp2Y = (ScreenHeight * 0.12) + randomYOffset
      let endY = (ScreenHeight * 0.29) + randomYOffset
      
      //print("card: \(card.cardNum), ys: \(startY), \(cp1Y), \(cp2Y), \(endY)")
      
      path.moveToPoint(CGPoint(x: startX, y: startY))  // previously 16 and 189
      path.addCurveToPoint(CGPoint(x: endX, y: endY),  // previously 301 and 139
        controlPoint1: CGPoint(x: cp1X, y: cp1Y),      // previously 136 and 323
        controlPoint2: CGPoint(x: cp2X, y: cp2Y))      // previously 178 and 60
      
      // create animation to animate the object's position
      let anim = CAKeyframeAnimation(keyPath: "position")
      anim.path = path.CGPath
      
      // rotate so that it's parallel to whatever point it is currently on the curve
      anim.rotationMode = kCAAnimationRotateAuto
      anim.repeatCount = Float.infinity
      // each square will take between 4 and 8 seconds to complete one loop
      anim.duration = Double(arc4random_uniform(40)+30) / 100
      // stagger each animation by a random value
      anim.timeOffset = Double(arc4random_uniform(290))
      
      // add the animation to the card's layer property
      card.layer.addAnimation(anim, forKey: "animate position along path")
      
      }
      
      delay(seconds: 1.2, completion: {
        self.currentCard = self.deck.last!
        self.moveCardUpToDisplay(self.deck.last!)
      })
      
    
    }
  
  
  /*
  *****************************************
  * Handle dismiss tap
  ******************************************
  */
  
  @objc func handleDismissTap() {
    
    // if a card is currently displayed, dismiss it then reshuffle the deck, else do nothing
    if let card = currentCard {
      dismissCardThenShuffle(card)
    }
    
  }
    
}
