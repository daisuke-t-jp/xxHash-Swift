//
//  ViewController.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/02/14.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import Cocoa

import xxHash_Swift

class ViewController: NSViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Common.oneshotXXH32()
    Common.oneshotXXH64()
    Common.oneshotXXH3_64()
    Common.oneshotXXH3_128()
    Common.streamingXXH32()
    Common.streamingXXH64()
  }
  
  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
}

