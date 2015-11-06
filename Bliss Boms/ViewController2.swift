//
//  ViewController2.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//


import UIKit

import UIKit

class ViewController2: UIViewController, UIGestureRecognizerDelegate {
  
  private let controller: FateController
  var deck = [CardView]()
  
  required init(coder aDecoder: NSCoder) {
    controller = FateController()
    super.init(coder: aDecoder)!
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    self.view.addSubview(gameView)
    
    let hudView = HUDView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    self.view.addSubview(hudView)
    
    controller.gameView = gameView
    controller.hud = hudView
    controller.initialiseGame()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    controller.startGame()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  
  
}