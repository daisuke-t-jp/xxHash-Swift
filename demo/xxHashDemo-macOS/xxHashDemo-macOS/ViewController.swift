//
//  ViewController.swift
//  xxHashDemo-macOS
//
//  Created by Daisuke T on 2019/02/14.
//  Copyright © 2019 xxHashDemo-macOS. All rights reserved.
//

import Cocoa

import xxHash_Swift

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(xxHash32.hash("test")) 
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

