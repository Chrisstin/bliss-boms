//
//  DefaultReading.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 17/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation

class DefaultReading: Reading {
  
  override init() {
    
    let cardNum = 999
    
    let heading = "Default Heading"
    
    let artist: String  = "Allyson Roesler"
    
    let description: [String] = [
      "This text is still to be written",
      
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      
    ]
    
    let synopsis: [String] = [
      
      "first",
      
      "second"
    ]

      super.init(cardNum: cardNum, heading: heading, description: description, synopsis: synopsis, artist: artist)
  }
}
