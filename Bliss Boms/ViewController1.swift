//
//  ViewController1.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UIGestureRecognizerDelegate {
  
  let gameController: SelectController
  var deck = [CardView]()
  
  required init(coder aDecoder: NSCoder) {
    // set up 3 deal controllers and pass into game controller
    let dc1 = SpiralController()
    let dc2 = FishController()
    let dc3 = SnakeController()
    
    gameController = SelectController(dealController1: dc1, dealController2: dc2, dealController3: dc3)
    super.init(coder: aDecoder)!
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    self.view.addSubview(gameView)
    
    let hudView = HUDView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    self.view.addSubview(hudView)
    
    gameController.gameView = gameView
    gameController.hud = hudView
    gameController.initialiseGame()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    gameController.startGame()
    
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    gameController.willDisappear()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  

  //override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
      let location = touch.locationInView(self.view)
      gameController.handleTouch(location)
    }
  }
  
  
  

  
}