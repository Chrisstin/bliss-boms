//
//  ReadingManager.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 18/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation

class ReadingManager {
  
  static var readings = [Int: Reading]()
  
  class func loadReadings() {
    
    FileReader.getReadingsFromFileWithSuccess( { (data) -> Void in
      
      ReadingManager.readings.removeAll(keepCapacity: false)
            
      // create an array of cards from the json file
      do {
        let parsedObject = try NSJSONSerialization.JSONObjectWithData(data,
          options: [.AllowFragments])
        
        if let allCards = parsedObject as? NSDictionary {
          
          if let cards = allCards["cards"] as? NSArray {
            
            for card in cards  {
              let reading = Reading()
              var missingInfo = false
              
              if let card = card as? NSDictionary {
                // card number
                if let stringNumber = card["number"] as? NSString {
                  let strNum = stringNumber as String
                  if let number = Int(strNum) {
                    reading.cardNum = number
                  } else {
                    missingInfo = true
                  }
                } else {
                  missingInfo = true
                }
                // heading
                if let heading = card["heading"] as? NSString {
                  reading.heading = heading as String
                } else {
                  missingInfo = true
                }
                // synopsis
                if let synopsises = card["synopsis"] as? NSArray {
                  for synopsis in synopsises {
                    if let synop = synopsis as? String {
                      reading.synopsis.append(synop)
                    }
                  }
                } else {
                  missingInfo = true
                }
                // description
                if let descriptions = card["description"] as? NSArray {
                  for description in descriptions {
                    if let descrip = description as? String {
                      reading.description.append(descrip)
                    }
                  }
                } else {
                  missingInfo = true
                }
                // artist
                if let artist = card["artist"] as? NSString {
                  reading.artist = artist as String
                } else {
                  missingInfo = true
                }
              }
              if !missingInfo {
                // only add to the array if there is no missing info
                ReadingManager.readings[reading.cardNum] = reading
              }
            }
          }
        }
        
        
      } catch let error as NSError {
        print("A JSON error occured: \n \(error)")
      }
      
      //print("number of readings loaded: \(ReadingManager.readings.count)")
    })
    
  }
  
  
  class func getReadingForCard(cardNum: Int) -> Reading {
    
    if ReadingManager.readings.count == 0 {
      loadReadings()
    }
    
    // check a reading exists for the card number supplied, else use the default reading
    if let reading = ReadingManager.readings[cardNum] {
      return reading
    } else {
      //create a default reading and return it
      print("reading not found for card \(cardNum).  using default reading")
      return DefaultReading()
    }
    
  }
}