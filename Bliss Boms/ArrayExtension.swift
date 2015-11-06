//
//  ArrayExtension.swift
//  Iris
//
//  Created by Christine Newbery on 24/07/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation

extension MutableCollectionType where Index == Int {
  // shuffle the elements of self in place
  mutating func shuffle() {
    if count < 2 {
      return
    }
    for i in 0..<count - 1 {
      let j = Int(arc4random_uniform(UInt32(count - i))) + i
      guard i != j else {
        continue
      }
      swap(&self[i], &self[j])
    }
  }
}
