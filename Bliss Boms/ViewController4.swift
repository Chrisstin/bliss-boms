//
//  ViewController4.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 30/11/2015.
//  Copyright © 2015 Christine Newbery. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
  
  @IBOutlet weak var homeView: HomeView!
  
  //let backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 252/255, alpha: 1.0)
  let backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
  
  override func viewDidLoad() {
    
    self.view.backgroundColor = backgroundColor
    self.homeView.layer.cornerRadius = 5.0

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
  
  
}
