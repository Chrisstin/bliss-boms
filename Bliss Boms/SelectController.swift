//
//  SelectController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class SelectController: GameController {

  // MARK: - Variables
  
  var dealController: DealController
  
  let dealController1: DealController
  let dealController2: DealController
  let dealController3: DealController
  var numLabelAnimations = 0
  
  
  // MARK: - Initial set up
  
  init(dealController1: DealController, dealController2: DealController, dealController3: DealController) {
    self.dealController1 = dealController1
    self.dealController2 = dealController2
    self.dealController3 = dealController3
    
    self.dealController = dealController1
    
    super.init()
  
  }
  
  
  
  /*
  *********************************************
  * Initialise Game - called from view did load
  *********************************************
  */
  override func initialiseGame() {
    
    super.initialiseGame()
    
    // load and connect the segmented control for which Deal type
    hud.loadDealTypeControl(colors[.SegControl]!, tintColor: colors[.SegControlTint]!)
    if let dealType = hud.dealType {
      dealType.addTarget(self, action: "handleChangeDeal:", forControlEvents: .ValueChanged)
    }
    
    delay(seconds: 3, completion: {
      // delay needed to ensure it is on the screen, else it doesn't animate
      self.hideDealTypeControl()
    })
    delay(seconds: 0.1, completion: {
      self.addTapLabel()
    })

    delay(seconds: 2.0, completion: {
      // delay needed to ensure it is on the screen, else it doesn't animate
      self.animateTapLabel()
    })
    
  }
  
  
  
  // MARK: - Animations
  
  
  /*
  ******************************************
  * Hide Deal Type Control
  ******************************************
  */
  func hideDealTypeControl() {
    
    UIView.animateWithDuration(2.0, delay: 0.0, options: [], animations: {
      self.hud.dealType!.alpha = 0.0
      }, completion: nil)
    
  }
  /*
  ******************************************
  * Show Hide Deal Type Control
  ******************************************
  */
  func showHideDealTypeControl() {
    UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: {
      self.hud.dealType!.alpha = 1.0
      }, completion: { _ in
        delay(seconds: 3.5, completion: {
          self.hideDealTypeControl()
        })
    })
  }
  

  
  /*
  *****************************************
  * Add Tap Label
  ******************************************
  */
  func addTapLabel() {
      
    hud.tapLabel = TapLabelView(frame: CGRectMake(0, 0, 200, 33), textColor: colors[.TapLabel]!)
    self.gameView.addSubview(hud.tapLabel!)
    hud.tapLabel!.setConstraints(-105)
  }
  

  /*
  *****************************************
  * Animate Tap Label
  ******************************************
  */
  func animateTapLabel() {
    
    if let label = hud.tapLabel {
      
      label.transform = CGAffineTransformMakeScale(0.7, 0.7)

      UIView.animateWithDuration(4.0,
        delay: 0.0,
        usingSpringWithDamping: 0.55,            // 0.45
        initialSpringVelocity:  0.0,                // 5.4,
        options: .CurveEaseInOut,
        animations: {
          self.numLabelAnimations++
          label.transform = CGAffineTransformIdentity
        },
        completion: { _ in
            // fade out and remove the label
            UIView.animateWithDuration(2.0,
              animations: {
                label.alpha = 0.0
              }, completion: { finished in
                self.hud.tapLabel?.removeFromSuperview()
                self.hud.tapLabel = nil
            })
        })
    }
    
    
  }
  // MARK: - Dealing
  
  /*
  *****************************************
  * Deal
  ******************************************
  */
  override func dealDeck() {
    
    super.dealDeck()
    
    showHideDealTypeControl()
    
    dealController.deal(gameView, deck: &deck)
    
  }
  
  /*
  *****************************************
  * Stop Dealing
  ******************************************
  */
  override func stopDealing() {
    
    dealController.stopDealing()
  }
  
  /*
  *****************************************
  * Will enter Foreground
  ******************************************
  */
  func willEnterForeground() {
    if currentCard == nil {
      shuffleAndDeal()
    }
  }
  /*
  *****************************************
  * Will Disappear
  ******************************************
  */
  func willDisappear() {

    currentCard?.hidden = true
    currentCard?.moveBackDown()
    currentCard?.hidden = false
    currentCard = nil

  }
  
  // MARK: - Touch events
  /*
  *****************************************
  * Change Deal Type
  ******************************************
  */
  
  @objc func handleChangeDeal(sender: UISegmentedControl) {
    
    // tell current deal controller to stop dealing - before switching to new deal controller
    dealController.stopDealing()
    
    // switch dealers
    switch sender.selectedSegmentIndex {
    case 0:
      // Spiral
      dealController = dealController1

    case 1:
      // Fish
      dealController = dealController2
      
    case 2:
      // Drop
      dealController = dealController3
      
    default:
      // set to spiral
      dealController = dealController1
    }
    
    // shuffle and redeal
    handleShuffleButtonTapped()
  }
  
  
  /*
  *****************************************
  * Handle touch
  ******************************************
  */
  
  func handleTouch(location: CGPoint) {
    
    
    //print("touch location is \(NSStringFromCGPoint(location))\n\n")
    
    // ensure tap label is hidden
    for subview in gameView.subviews {
      if subview is TapLabelView {
        subview.removeFromSuperview()
        hud.tapLabel = nil
      }
    }
    
    // Case 1 - a card is already being displayed.  Flip it or dismiss it
    if let card = currentCard {
      if let layer: AnyObject! = card.layer.presentationLayer() {
        if CGRectContainsPoint(layer!.frame, location) {
          flipCard()
        } else {
          // tapped outside the card - dismiss it
          dismissCardThenShuffle(card)
        }
      }
      return
    }

    // Case 2 - no card is currently displayed.  Check if a new card is tapped.
    var topMostCard = 0
    var CardTapped = false
    
    for card in deck {      
      //if let layer: AnyObject! = card.layer.presentationLayer() {
      if let layer = card.layer.presentationLayer() as? CALayer {
        let insetRect = CGRectInset(layer.frame, 30, 30)
        if CGRectContainsPoint(insetRect, location) {
          CardTapped = true
          if card.viewOrder > topMostCard && card.superview != nil {
            topMostCard = card.viewOrder
            currentCard = card
          }
        }
      }
    }
    
    
    if CardTapped {
      if let currCard = currentCard {
        numCardsTapped++
        hud.dealType!.alpha = 0.0
        moveCardUpToDisplay(currCard)
      } else {
        showHideDealTypeControl()
      }
    } else {
        showHideDealTypeControl()
    }
  }
  
  
}
