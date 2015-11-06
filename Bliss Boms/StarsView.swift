//
//  StarsView.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 23/07/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//

import Foundation
import UIKit

class StarsView: UIView {
  private var emitter: CAEmitterLayer!
  
  // configure the UIView to have an emitter layer
  override class func layerClass() -> AnyClass {
    return CAEmitterLayer.self
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("use init(frame:)")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    emitter = self.layer as! CAEmitterLayer
    emitter.emitterPosition = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
    emitter.emitterSize = self.bounds.size
    emitter.emitterMode = kCAEmitterLayerAdditive
    emitter.emitterShape = kCAEmitterLayerRectangle
    
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    if self.superview == nil {
      return
    }
    
    let texture: UIImage? = UIImage(named: "spark")
    assert(texture != nil, "spark image not found")
    
    let emitterCell = CAEmitterCell()
    emitterCell.contents = texture!.CGImage
    emitterCell.name = "cell"
    
    emitterCell.birthRate = 1000 // per second
    emitterCell.lifetime = 1.00  // seconds
    
    // if want pink
    emitterCell.greenRange = 0.2  // randomly vary the green component
    emitterCell.greenSpeed = -0.2  // decrease the green component over time, decreasing the intensity of the colour
    
    // if want yellow
//     emitterCell.blueRange = 0.33
//     emitterCell.blueSpeed = -0.33
    
    // if want green
//     emitterCell.redRange = 0.33
//     emitterCell.redSpeed = -0.33
    
    //    emitterCell.yAcceleration = 100
    //    emitterCell.xAcceleration = -200
    
    emitterCell.velocity = 370
    emitterCell.velocityRange = 100  // i.e. the base value +/- this value
    
    emitterCell.scaleRange = 0.5
    emitterCell.scaleSpeed = -0.2  // shrink over time
    
    emitterCell.emissionRange = CGFloat(M_PI*2) // 360 degrees
    
    emitter.emitterCells = [emitterCell]
    
    delay(seconds: 0.1, completion: {
      self.disableEmitterCell()
    })
    
    delay(seconds: 0.75, completion: {
      self.removeFromSuperview()
    })
    
  }
  
  func disableEmitterCell() {
    emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
  }
}

