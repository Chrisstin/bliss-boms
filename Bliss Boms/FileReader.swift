//
//  FileReader.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 16/10/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation

class FileReader {
  
  class func getReadingsFromFileWithSuccess(success: ((data: NSData) -> Void)) {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      
      let filePath = NSBundle.mainBundle().pathForResource("blissboms",ofType:"json")
      
      
      if let filePath = filePath {
        
        do {
          let data = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingUncached)
          success(data: data)
        } catch {
          let dataError = error as NSError
          print("error reading json data: \(dataError)")
          
        }

      } else {
        print("file not found")
      }
  })
    
  }
}