//
//  Config.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

var NumCards = 16

// UI Constants
var ScreenWidth = UIScreen.mainScreen().bounds.size.width
var ScreenHeight = UIScreen.mainScreen().bounds.size.height

// set the card width and height multipliers.  width is in relation to the screen width.  height is in relation to the card's width.
// height ratio will be different depending on device size.  set in game controller
let CardWidthCircle: CGFloat = 0.4
let CardHeightCircle: CGFloat = 1

let CardWidthRectangle: CGFloat = 0.5
var CardHeightRectangle: CGFloat = 1.33
let CardHeightRectangleSmallerRatio: CGFloat = 1.15
let CardHeightRectangleBiggerRatio: CGFloat = 1.33

let CardWidthLarge: CGFloat = 0.95
var CardHeightLarge: CGFloat = 1.33
let CardHeightLargeSmallerRatio: CGFloat = 1.15
let CardHeightLargeBiggerRatio: CGFloat = 1.33

// Animation speeds
let CardRiseSpeed: NSTimeInterval = 1.5
let CardFlipSpeed: NSTimeInterval = 1.5
let CardDismissSpeed: NSTimeInterval = 1.0
let ShuffleSpeed: NSTimeInterval = 0.0

// Theme colours
enum ColType {
  case Animation,
  Display,
  ShuffleButtonNormal,
  ShuffleButtonDisabled,
  ShuffleButtonImageTint,
  TapLabel,
  SegControl,
  SegControlTint
}

let Theme1 : [ColType : UIColor] = [
  ColType.Animation :             UIColor(red: 227/255, green: 230/255, blue: 242/255, alpha: 1.0),
  ColType.Display :               UIColor(red: 43/255, green: 45/255, blue: 46/255, alpha: 1.0),
  ColType.ShuffleButtonNormal :   UIColor(red: 227/255, green: 230/255, blue: 242/255, alpha: 1.0),
  ColType.ShuffleButtonDisabled : UIColor(red: 255/255, green: 246/255, blue: 255/255, alpha: 1.0),
  ColType.ShuffleButtonImageTint: UIColor(red: 173/255, green: 179/255, blue: 201/255, alpha: 0.8),
  ColType.TapLabel :              UIColor(red: 37/255, green: 94/255, blue: 158/255, alpha: 1.0),
  ColType.SegControl :            UIColor(red: 227/255, green: 230/255, blue: 242/255, alpha: 1.0),
  ColType.SegControlTint:         UIColor(red: 47/255, green: 104/255, blue: 168/255, alpha: 1.0),
]

let Theme2 : [ColType : UIColor] = [
  ColType.Animation :             UIColor(red: 235/255, green: 230/255, blue: 237/255, alpha: 1.0),
  ColType.Display :               UIColor(red: 232/255, green: 223/255, blue: 237/255, alpha: 1.0),
  ColType.ShuffleButtonNormal :   UIColor(red: 116/255, green: 70/255, blue: 145/255, alpha: 1.0),
  ColType.ShuffleButtonDisabled : UIColor(red: 143/255, green: 111/255, blue: 232/255, alpha: 1.0),
  ColType.TapLabel :              UIColor(red: 193/255, green: 188/255, blue: 196/255, alpha: 1.0),
  ColType.SegControl :            UIColor(red: 193/255, green: 177/255, blue: 201/255, alpha: 1.0),
  ColType.SegControlTint:         UIColor(red: 47/255, green: 104/255, blue: 168/255, alpha: 1.0),
]

let Theme3 : [ColType : UIColor] = [
  ColType.Animation :             UIColor(red: 240/255, green: 242/255, blue: 250/255, alpha: 1.0),
  ColType.Display :               UIColor(red: 220/255, green: 224/255, blue: 242/255, alpha: 1.0),
  ColType.ShuffleButtonNormal :   UIColor(red: 71/255, green: 61/255, blue: 128/255, alpha: 1.0),
  ColType.ShuffleButtonDisabled : UIColor(red: 255/255, green: 246/255, blue: 255/255, alpha: 1.0),
  ColType.TapLabel :              UIColor(red: 71/255, green: 71/255, blue: 118/255, alpha: 1.0),
  ColType.SegControl :            UIColor(red: 220/255, green: 220/255, blue: 245/255, alpha: 1.0),
  ColType.SegControlTint:         UIColor(red: 59/255, green: 53/255, blue: 140/255, alpha: 1.0),
]

let BrowseBackgroundColour = UIColor(red: 43/255, green: 45/255, blue: 46/255, alpha: 1.0)


// Random number generator
func randomNumber(min:UInt32, max:UInt32) -> Int {
  let result = (arc4random() % (max - min + 1)) + min
  return Int(result)
}

// delay function
func delay(seconds seconds: Double, completion:()->()) {
  let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
  dispatch_after(popTime, dispatch_get_main_queue()) {
    completion()
  }
}
