//
//  PageItemController.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
  
  // same class is used for each card, so need itemIndex to identify which card we are up to in the deck
  // Following fields are set immediately after PageItemController is instantiated in ViewController3
  var itemIndex: Int = 0
  var currentCard: CardView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = BrowseBackgroundColour
  }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
    // card
    self.view.addSubview(currentCard!)
    let recogniser = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
    currentCard!.addGestureRecognizer(recogniser)
    currentCard!.createDisplayConstraints()
  
  }
  
  /*
  *****************************************
  * Handle tap
  ******************************************
  */
  @objc func handleTap(recogniser: UITapGestureRecognizer) {
    
    currentCard = recogniser.view! as? CardView
    if currentCard == nil {
      // reading view was tapped, get parent which is the card view
      currentCard = recogniser.view!.superview! as? CardView
    }
    if currentCard == nil {
      return
    }
    
    var flipDirection = UIViewAnimationOptions.TransitionFlipFromRight
    if currentCard!.currentFace == .Reading {
      flipDirection = UIViewAnimationOptions.TransitionFlipFromLeft
    }
    
    currentCard!.setReadingView()
    UIView.transitionWithView(self.currentCard!, duration: CardFlipSpeed, options: flipDirection, animations: {
      self.currentCard!.swapCardFace()
      }, completion: { _ in
        self.currentCard?.readingView?.flashScrollIndicators()
    })
    
  }
  
  
  
}
