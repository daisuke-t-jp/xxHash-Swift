//
//  ViewController.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/02/14.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import UIKit

import xxHash_Swift

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Common.oneshot32()
    Common.oneshot64()
    Common.oneshot3_64()
    Common.oneshot3_128()
    Common.streaming32()
    Common.streaming64()
  }
  
}

