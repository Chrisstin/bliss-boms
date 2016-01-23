//
//  ReadingView.swift
//  BLiss Boms
//
//  Created by Christine Newbery on 23/07/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import UIKit

class ReadingView: UITextView {
  
  let cardNum: Int
  
  var heading = ""
  var headingText = ""
  var descripText = ""
  var synopText = ""
  var artistText = ""
  
  var toolbar: UIToolbar!
  var shareItem: UIBarButtonItem!

  
  required init(coder aDecoder: NSCoder) {
    fatalError("use init(cardNum: frame:")
  }
  
  // MARK: Init
  
  /*
  *****************************************
  * Initialiser
  ******************************************
  */
  init(cardNum: Int, frame: CGRect) {
    
    self.cardNum = cardNum
    let textContainer: NSTextContainer? = nil
    super.init(frame: frame, textContainer: textContainer)
    
    createText()

    self.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    self.layer.masksToBounds = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.userInteractionEnabled = true
    self.editable = false
    self.selectable = false
    self.layer.cornerRadius = 5.0
    
    self.setContentOffset(CGPointZero, animated: false)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredTextSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    
    loadToolbar()
    
  }
  

  /*
  *****************************************
  * Create Text
  ******************************************
  */
  
  func createText() {

    // initialise
    self.textStorage.mutableString.setString("")
    descripText.removeAll(keepCapacity: true)
    synopText.removeAll(keepCapacity: true)
    
    // get reading text for this card number
    let reading = ReadingManager.getReadingForCard(self.cardNum)
    heading = reading.heading
    
    // set up Heading, Description, Synopsis and Caption Texts
    headingText = "\n" + reading.heading + "\n\n"
    
    for description in reading.description {
      descripText += description
      descripText += "\n\n"
    }
    
    for synopsis in reading.synopsis {
      let str = "\u{2022}" + "\t" + synopsis + "\n\n"
      synopText += str
    }
    
    artistText = "Artwork by " + reading.artist
    
    // create the fonts - based on user's settings
    // except for Heading - override the size to 25% larger than body
    let fontB = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    let fontHStandard = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let fontHSize = fontB.pointSize + (fontB.pointSize * 0.33)
    let fontH = fontHStandard.fontWithSize(fontHSize)
    let fontC = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
    
    // other attributes
    let textColor = Colors[.Text]!
    let paraStyleH = NSMutableParagraphStyle()
    paraStyleH.alignment = .Center
    let paraStyleB = NSMutableParagraphStyle()
    paraStyleB.alignment = .Left
    let paraStyleList = NSMutableParagraphStyle()
    paraStyleList.alignment = .Left
    paraStyleList.headIndent = 26
    paraStyleList.firstLineHeadIndent = 0
    let paraStyleC = NSMutableParagraphStyle()
    paraStyleC.alignment = .Right
    
    // heading
    var attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontH,
      NSParagraphStyleAttributeName : paraStyleH
    ]
    var attributedString = NSAttributedString(string: headingText, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)
    
    // synopsis
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontB,
      NSParagraphStyleAttributeName : paraStyleList
    ]
    attributedString = NSAttributedString(string: synopText, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)
    
    // description
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontB,
      NSParagraphStyleAttributeName : paraStyleB
    ]
    attributedString = NSAttributedString(string: descripText, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)
    
    // caption
    attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : fontC,
      NSParagraphStyleAttributeName : paraStyleC
    ]
    attributedString = NSAttributedString(string: artistText, attributes: attributes)
    self.textStorage.appendAttributedString(attributedString)
    
  }
 
  
  /*
  *****************************************
  * Set Constraints
  ******************************************
  */
  func setConstraints() {
    let conLdg = NSLayoutConstraint(
      item: self,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: self.superview,
      attribute: .Leading,
      multiplier: 1.0,
      constant: 15.0)
    conLdg.active = true
    let conTrg = NSLayoutConstraint(
      item: self,
      attribute: .Trailing,
      relatedBy: .Equal,
      toItem: self.superview,
      attribute: .Trailing,
      multiplier: 1.0,
      constant: -15.0)
    conTrg.active = true
    let conTop = NSLayoutConstraint(
      item: self,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: self.superview,
      attribute: .Top,
      multiplier: 1.0,
      constant: 15.0)
    conTop.active = true
    let conBot = NSLayoutConstraint(
      item: self,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self.superview,
      attribute: .Bottom,
      multiplier: 1.0,
      constant: -15.0)
    conBot.active = true
  }
  /*
  *****************************************
  * Load Toolbar
  ******************************************
  */
  func loadToolbar() {
    toolbar = UIToolbar()
    toolbar = UIToolbar(frame: CGRect(x: self.frame.width - 80, y: 0, width: 80, height: 44))
    

    shareItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share")
    let items = [shareItem!]
    toolbar.setItems(items, animated: false)
    addSubview(toolbar)
    toolbar.barTintColor = UIColor.whiteColor()
    toolbar.tintColor = Colors[.Text]!
    
  }
  
  // MARK: Other
  
  
  func preferredTextSizeChanged(notification: NSNotification) {
    createText()
  }
  
  /*
  *****************************************
  * Share
  ******************************************
  */
  func share() {
    let image = UIImage(named: "card \(cardNum)")
    let text = heading + " #OracleCards @Bliss_Boms. Read more at"
    var link = FirstBitURL
    if let cardUrl = URLs[cardNum] {
      link += cardUrl
    }
    
    let activity = UIActivityViewController(activityItems: [text, link, image!], applicationActivities: nil)
    let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
    rootVC!.presentViewController(activity, animated: true, completion: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(UIContentSizeCategoryDidChangeNotification)
    
  }
  
}
