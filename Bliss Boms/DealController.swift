//
//  DealController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 24/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class DealController {
  
  /*
  *****************************************
  * Deal
  ******************************************
  */
  func deal(gameView: UIView, inout deck: [CardView]) {
    
    deck.shuffle()
    
    // ensure all cards have image displayed and are displayed as circles
    for card in deck {
      if card.currentFace == .Reading {
        card.swapCardFace()
      }
      card.layer.cornerRadius = card.frame.size.width/2
//      if card.cardNum == 2 {
//        print("horiz")
//        print(card.constraintsAffectingLayoutForAxis(.Horizontal))
//        print("vert")
//        print(card.constraintsAffectingLayoutForAxis(.Vertical))
//        print("horiz gamev")
//        print(gameView.constraintsAffectingLayoutForAxis(.Horizontal))
//        print("vert gamev")
//        print(gameView.constraintsAffectingLayoutForAxis(.Vertical))
//      }
      
      //delete all card layout constraints in case has switched from different dealer
      NSLayoutConstraint.deactivateConstraints(card.origConstraints)
      NSLayoutConstraint.deactivateConstraints(card.displayConstraints)
      card.origConstraints.removeAll(keepCapacity: true)
      card.displayConstraints.removeAll(keepCapacity: true)
      card.transform = CGAffineTransformIdentity
      card.setCorners()
    }
    
    

  }
  
  /*
  *****************************************
  * Stop Dealing
  ******************************************
  */
  func stopDealing() {
    
  }
  
}

