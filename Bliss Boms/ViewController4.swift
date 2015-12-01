//
//  ViewController4.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 30/11/2015.
//  Copyright © 2015 Christine Newbery. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
  
  @IBOutlet weak var visitButton: UIButton!
  @IBOutlet weak var homeView: HomeView!
  
  let backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 252/255, alpha: 1.0)
  
  override func viewDidLoad() {
    
    self.view.backgroundColor = backgroundColor
    self.homeView.backgroundColor = backgroundColor
    self.visitButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
//    let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
//    self.homeView.addGestureRecognizer(pinch)

  }
  
  override func viewWillAppear(animated: Bool) {
    homeView.setContentOffset(CGPointMake(0, -10), animated: false)
  }
  
  override func viewDidAppear(animated: Bool) {
    homeView.flashScrollIndicators()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
//  @objc func handlePinch(recogniser: UIPinchGestureRecognizer) {
//    if recogniser.state == .Changed {
//      homeView.font = UIFont.
//    }
//  }
  

  @IBAction func visitWebsite(sender: AnyObject) {
    UIApplication.sharedApplication().openURL(NSURL(string: "http://allysonroesler.wix.com/backtobliss#!contact/c21dx")!)
  }
  
}
