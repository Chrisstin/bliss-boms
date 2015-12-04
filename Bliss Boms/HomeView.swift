//
//  HomeView.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 30/11/2015.
//  Copyright © 2015 Christine Newbery. All rights reserved.
//

import UIKit

class HomeView: UITextView {
  
  var heading = ""
  var descrip = ""

  
    /*
    *****************************************
    * Initialiser
    ******************************************
    */
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    createText()
    
    self.layer.masksToBounds = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.userInteractionEnabled = true
    self.editable = false
    self.selectable = true
    
    self.setContentOffset(CGPointZero, animated: false)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredTextSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  
  
  /*
  *****************************************
  * Create Text
  ******************************************
  */
  
  func createText() {
    
    // initialise
    self.textStorage.mutableString.setString("")    
    
    // set up Heading and Description
    heading = "Bliss Boms" + "\n\n"
    
    descrip = "If you‘re feeling sad, grumpy, depressed or down right angry." + "\n\n"
    descrip += "If the world around you is making you feel like there’s something wrong with you, or circumstances and events are making you feel like you’re missing out, or you’re just not getting this reality or not fitting in." + "\n\n"
    descrip += "Then grab a Bliss Bom!" + "\n\n"
    descrip += "You’ll be sure to be Back to Bliss in no time!" + "\n\n"
    descrip += "Just like a bomb, Bliss Boms are designed to explode the underlying thought that is creating your current mood and give you the opportunity to choose something different. Reality is not a set, rigid, defined thing. It is dynamic and ever changing." + "\n\n"
    descrip += "Simply select the card you're drawn to, or let Fate choose for you, or browse the entire pack.  Then read your way into a better mood and watch your life change for the better!" + "\n\n"
    descrip += "Additional cards coming soon."     
    
    // create the fonts - based on user's settings
    // except for Heading - override the size to 25% larger than body
    let fontB = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    let fontHStandard = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let fontHSize = fontB.pointSize + (fontB.pointSize * 0.33)
    let fontH = fontHStandard.fontWithSize(fontHSize)
    
    // other attributes
    //let textColor = UIColor(red: 0.51, green: 0.18, blue: 0.73, alpha: 1)  // same colour as card text
    let textColor = UIColor(red: 78/255, green: 78/255, blue: 148/255, alpha: 1)
    let paraStyleH = NSMutableParagraphStyle()
    paraStyleH.alignment = .Center
    let paraStyleB = NSMutableParagraphStyle()
    paraStyleB.alignment = .Left
    
    // heading
    var attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontH,
      NSParagraphStyleAttributeName : paraStyleH
    ]
    let attributedString = NSAttributedString(string: heading, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)

    
    // description
    let descripStr = descrip as NSString
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontB,
      NSParagraphStyleAttributeName : paraStyleB
    ]
    let italicFontAttribute = [NSFontAttributeName: UIFont.italicSystemFontOfSize(fontB.pointSize)]
    let mutableAttributedString = NSMutableAttributedString(string: descripStr as String, attributes: attributes)
    // bold part of the text
    //let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFontOfSize(fontB.pointSize)]
    //mutableAttributedString.addAttributes(boldFontAttribute, range: descripStr.rangeOfString("Then grab a Bliss Bom!"))
    mutableAttributedString.addAttributes(italicFontAttribute, range: descripStr.rangeOfString("Then grab a Bliss Bom!"))
    
    self.textStorage.appendAttributedString(mutableAttributedString)
    
    
  }
  
  
  func preferredTextSizeChanged(notification: NSNotification) {
    createText()
  }
  

  
  
  deinit {
    print("de-initialising reading view")
    NSNotificationCenter.defaultCenter().removeObserver(UIContentSizeCategoryDidChangeNotification)
    
  }
  
}
