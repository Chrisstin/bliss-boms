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
      card.moveToCentre(0, yConst: -20.0)

      let path = UIBezierPath()
      // add random y offset so that each individual animation will appear at a different y
      let randomYOffset = CGFloat( arc4random_uniform(250))
      
      path.moveToPoint(CGPoint(x: 16, y: 189 + randomYOffset))
      path.addCurveToPoint(CGPoint(x: 301, y: 139 + randomYOffset),
        controlPoint1: CGPoint(x: 136, y: 323 + randomYOffset),
        controlPoint2: CGPoint(x: 178, y: 60 + randomYOffset))
      
      let anim = CAKeyframeAnimation(keyPath: "position")
      anim.path = path.CGPath
      
      // rotate each card so that it's parallel to whatever point it is currently on the curve
      anim.rotationMode = kCAAnimationRotateAuto
      anim.repeatCount = 1
      // each square will take between half a second and a second to complete one loop
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
