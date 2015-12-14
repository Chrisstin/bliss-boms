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
  var caption = ""

  
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
   //descrip += "Reality is not a set, rigid, defined thing.  It is dynamic and ever changing.  Simply read your way into a better mood and watch your life change for the better! Bliss boms has three options for you to do this:" + "\n\n"
    descrip += "'Select' allows you to chose a card that you feel drawn to.  The cards are all displayed as circles with three fascinating displays, Swirl, Fish and Snake. Simply tap on the card you are drawn to and read your way to bliss." + "\n\n"
    descrip += "'Fate Chooses' allows for a random oracle type reading to bliss.  Don't be fooled. The most appropriate card for you at this time will be presented to you; there are no coincidences in life" + "\n\n"
    descrip += "'Browse' allows you to explore each and every card in detail. Just enjoy all the beautiful pictures or flip them to read their bliss." + "\n\n"
    descrip += "Additional cards coming soon." + "\n\n"
    
    caption = "Bliss Boms is a creation of Back To Bliss; a business created to invite you back to bliss.  Individual sessions are available in Ashmore, Queensland, Australia."
    
    // create the fonts - based on user's settings
    // except for Heading - override the size to 33% larger than body
    let fontB = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    let fontHStandard = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let fontHSize = fontB.pointSize + (fontB.pointSize * 0.33)
    let fontH = fontHStandard.fontWithSize(fontHSize)
    let fontC = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
    
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
    var attributedString = NSAttributedString(string: heading, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)

    
    // description
    let descripStr = descrip as NSString
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontB,
      NSParagraphStyleAttributeName : paraStyleB
    ]
    // italicise part of the text
    let italicFontAttribute = [NSFontAttributeName: UIFont.italicSystemFontOfSize(fontB.pointSize)]
    let mutableAttributedString = NSMutableAttributedString(string: descripStr as String, attributes: attributes)
    mutableAttributedString.addAttributes(italicFontAttribute, range: descripStr.rangeOfString("Then grab a Bliss Bom!"))
    // bold parts of the text
    let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFontOfSize(fontB.pointSize)]
    mutableAttributedString.addAttributes(boldFontAttribute, range: descripStr.rangeOfString("'Select'"))
    mutableAttributedString.addAttributes(boldFontAttribute, range: descripStr.rangeOfString("'Fate Chooses'"))
    mutableAttributedString.addAttributes(boldFontAttribute, range: descripStr.rangeOfString("'Browse'"))
    
    self.textStorage.appendAttributedString(mutableAttributedString)
    
    // caption
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontC,
      NSParagraphStyleAttributeName : paraStyleB
    ]
    attributedString = NSAttributedString(string: caption, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)
    
  }
  
  
  func preferredTextSizeChanged(notification: NSNotification) {
    createText()
  }
  
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(UIContentSizeCategoryDidChangeNotification)
    
  }
  
}
