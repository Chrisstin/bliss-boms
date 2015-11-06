//
//  Reading.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 15/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation

class Reading {
  
  var cardNum: Int = 999
  
  var heading: String = ""
  
  var synopsis = [String]()
  
  var description =  [String]()
  
  var artist: String  = ""
  
  init() {

  }
  
  init(cardNum: Int, heading: String, description: [String], synopsis: [String], artist: String) {
    self.cardNum = cardNum
    self.heading = heading
    self.description = description
    self.synopsis = synopsis
    self.artist = artist
  }

}