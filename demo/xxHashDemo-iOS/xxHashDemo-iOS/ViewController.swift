//
//  ViewController.swift
//  xxHashDemo-iOS
//
//  Created by Daisuke T on 2019/02/14.
//  Copyright © 2019 xxHashDemo-iOS. All rights reserved.
//

import UIKit

import xxHash_Swift

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(xxHash32.hash("test"))
	}


}

