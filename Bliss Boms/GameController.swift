//
//  GameController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 29/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class GameController {
  
  // MARK: - Variables
  
  var shuffleAnimationCount = 0
  
  var gameView: UIView!
  var hud: HUDView! {
    didSet {
      // connect the shuffle button
      hud.shuffleButton.addTarget(self, action: Selector("handleShuffleButtonTapped"), forControlEvents: .TouchUpInside)
      hud.shuffleButton.setTitleColor(colors[.ShuffleButtonNormal], forState: .Normal)
      hud.shuffleButton.tintColor = colors[.ShuffleButtonImageTint]
      hud.shuffleButton.setTitleColor(colors[.ShuffleButtonDisabled], forState: .Disabled)
    }
  }
  
  var deck = [CardView]()
  var currentCard: CardView?
  
  var colors = Theme1
  
  var numDeals = 0
  var numCardsTapped = 0

  
  // MARK: - Initial set up
  
  /*
  ******************************************
  * Initialiser
  ******************************************
  */
  init() {
    
    createDeck()
    setColors()
    
    // set correct height ratio depending on screen size
    // ratio is for the cards and is in relation to the card width
    // 1.33 is ideal but too big for short screens
    
    if ScreenHeight / ScreenWidth < 1.7 {
      CardHeightRectangle = CardHeightRectangleSmallerRatio
      CardHeightLarge     = CardHeightLargeSmallerRatio
    } else {
      CardHeightRectangle = CardHeightRectangleBiggerRatio
      CardHeightLarge = CardHeightLargeBiggerRatio
    }

  }
  
  
  /*
  ******************************************
  * Create deck
  ******************************************
  */
  func createDeck() {
    
    for cardNum in 1...NumCards {    
      let card = CardView(cardNum: cardNum)
      self.deck.append(card)
    }
  }
  
  
  /*
  ******************************************
  * Set Colors
  ******************************************
  */
  func setColors() {
    colors = Theme1
  }
  
  
  /*
  *****************************************
  * Initialise Game - called from view did load
  ******************************************
  */
  func initialiseGame() {

    
  }
  
  /*
  ******************************************
  * Start Game - called from view did appear
  ******************************************
  */
  func startGame() {
    
    self.gameView.backgroundColor = colors[.Animation]
    currentCard = nil
    shuffleAndDeal()
    
  }
  
  // MARK: - Animations

  
  
  /*
  *****************************************
  * Stop Animations
  ******************************************
  */
  func stopAnimations() {
    for card in deck {
      if let layer = card.layer.presentationLayer() as? CALayer {
      //var frame = layer.frame
      layer.removeAllAnimations()
      // keeps the card where it was when the animation was stopped, else will jump to posn at end of animation
      //      card.frame = frame
      }
    }
  }
  
  
  
  // MARK: - Shuffle and Deal Functions
  
  
  /*
  *****************************************
  * Handle Shuffle Button Tapped
  ******************************************
  */
  @objc func handleShuffleButtonTapped() {
    
    // is a card currently displayed?
    if let card = currentCard {
      dismissCardThenShuffle(card)
    } else {
      // just shuffle
      shuffleAndDeal()
    }
    
  }
  
  /*
  *****************************************
  * Dismiss Card then shuffle
  ******************************************
  */
  
  @objc func dismissCardThenShuffle(card: CardView) {
    
    self.stopAnimations()
    
    if card.currentFace == .Reading {
      UIView.transitionWithView(card, duration: 1.0, options: .TransitionFlipFromLeft, animations: {
        card.swapCardFace()
        }, completion: {_ in
          self.moveCardDownThenShuffle(card)
      })
    } else {
      self.moveCardDownThenShuffle(card)
    }
    currentCard = nil
    
  }
  /*
  *****************************************
  * Move card down then shuffle
  ******************************************
  */
  
  func moveCardDownThenShuffle(card: CardView) {
    
    currentCard = nil
    
    UIView.animateWithDuration(CardDismissSpeed, delay: 0.0, options: .CurveEaseOut, animations: {
      card.moveBackDown()
      card.alpha = 0
      self.gameView.backgroundColor = self.colors[.Animation]
      self.gameView.layoutIfNeeded()
      }, completion: { finished in
        if finished {
          self.shuffleAndDeal()
        }
    })
    
  }
  
  /*
  *****************************************
  * Shuffle and Deal
  ******************************************
  */
  @objc func shuffleAndDeal() {
    
    hud.shuffleButton.enabled = false
    
    UIView.animateWithDuration(ShuffleSpeed, delay: 0.0, options: .CurveEaseOut, animations: {
      for card in self.deck {
        card.alpha = 0.0
      }
      self.gameView.backgroundColor = self.colors[.Animation]
      }, completion: { _ in
        self.stopAnimations()
        for subview in self.gameView.subviews {
          subview.removeFromSuperview()
          if let card = subview as? CardView {
            // scroll all readings back to the top of the text
            card.scrollReadingToTop()
          }
        }
        self.dealDeck()
        self.hud.shuffleButton.enabled = true
        
        self.configureShuffleButtonImage()
    })
  }
  
  func configureShuffleButtonImage() {
    self.hud.configureShuffleButtonWithImage()
  }
  
  /*
  *****************************************
  * Deal
  ******************************************
  */
  func dealDeck() {
    
    numDeals++
  }
  
  
  // MARK: - Handle taps
  
  
  /*
  *****************************************
  * Display and Flip Card
  ******************************************
  */
  func moveCardUpToDisplay(card: CardView) {
    
    if currentCard == nil {
      return
    }
    hud.configureShuffleButtonNoImage()
    
    //print("card \(currentCard!.cardNum) was tapped, frame: \(NSStringFromCGRect(currentCard!.frame))")
    
    stopAnimations()
    
    stopDealing()
    
    // move card up
    UIView.animateWithDuration(CardRiseSpeed, delay: 0.0, options: .CurveEaseOut, animations: {
      self.gameView.bringSubviewToFront(card)
      card.moveUpToDisplay()
      for card in self.deck {
        // hide the other cards
        if card.cardNum != self.currentCard!.cardNum {
          card.alpha = 0.0
        }
        
      }
      self.gameView.layoutIfNeeded()
      
      // flip the card
      }, completion: { finished in
        if finished {
          self.flipCard()
        }
    })
    
    
  }
  
  /*
  *****************************************
  * Stop Dealing
  ******************************************
  */
  func stopDealing() {
    
  }
  
  /*
  *****************************************
  * Flip Card
  ******************************************
  */
  @objc func flipCard() {
    
    if currentCard == nil {
      return
    }
    
    // stars
    let stars = StarsView(frame: CGRectMake(self.currentCard!.center.x, self.currentCard!.center.y, 10, 10))
    self.currentCard?.superview?.addSubview(stars)
    self.currentCard?.superview?.sendSubviewToBack(stars)
    
    // flip direction
    var flipDirection = UIViewAnimationOptions.TransitionFlipFromRight
    if self.currentCard!.currentFace == .Reading {
      flipDirection = UIViewAnimationOptions.TransitionFlipFromLeft
    }
    
    //flip card
    currentCard!.setReadingView()
    UIView.transitionWithView(self.currentCard!, duration: CardFlipSpeed, options: flipDirection, animations: {
      self.gameView.backgroundColor = self.colors[.Display]
      self.currentCard!.swapCardFace()
      
      let recogniser = UITapGestureRecognizer(target: self, action: Selector("flipCard"))
      self.currentCard!.readingView.addGestureRecognizer(recogniser)
      }, completion: { _ in
        self.currentCard?.readingView?.flashScrollIndicators()
    })
  }
  

  
}

