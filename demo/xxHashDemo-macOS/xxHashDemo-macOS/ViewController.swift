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

		oneshot32()
		oneshot64()
		streaming32()
		streaming64()
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


	
	/**
	 * Generate Hash(One-shot)
	 *
	 * 32bit Version
	 */
	private func oneshot32() {
		do {
			let hash = xxHash32.digest("123456789ABCDEF")
			print("xxHash32 One-shot -> 0x\(String(format: "%02x", hash))")
		}

		do {
			let hash = xxHash32.digest("123456789ABCDEF", seed: 0x7fffffff)
			print("xxHash32 One-shot(0x7fffffff) -> 0x\(String(format: "%02x", hash))")
		}
	}
	
	/**
	 * Generate Hash(One-shot)
	 *
	 * 64bit Version
	 */
	private func oneshot64() {
		do {
			let hash = xxHash64.digest("123456789ABCDEF")
			print("xxHash64 One-shot -> 0x\(String(format: "%02lx", hash))")
		}
		
		do {
			let hash = xxHash64.digest("123456789ABCDEF", seed: 0x000000007fffffff)
			print("xxHash64 One-shot(0x000000007fffffff) -> 0x\(String(format: "%02lx", hash))")
		}
	}
	
	
	
	/**
	 * Generate Hash(Streaming)
	 *
	 * 32bit Version
	 */
	private func streaming32() {
		let xxh = xxHash32() // if using seed, e.g. "xxHash(0x7fffffff)"
		
		// Get data from file
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: "alice29", ofType: "txt")!
		let data = NSData(contentsOfFile: path)
		let array = [UInt8](data! as Data)
		
		let bufSize = 1024
		var index = 0
		var flag = true
		
		
		repeat {
			// Prepare buffer
			var buf = [UInt8]()
			for _ in 0..<bufSize {
				buf.append(array[index])
				index += 1
				if index >= array.count {
					flag = false
					break
				}
			}
			
			// xxHash update
			xxh.update(buf)
			
		} while(flag)
		
		let hash = xxh.digest()
		print("xxHash32 Streaming -> 0x\(String(format: "%02x", hash))")
	}

	/**
	 * Generate Hash(Streaming)
	 *
	 * 64bit Version
	 */
	private func streaming64() {
		let xxh = xxHash64() // if using seed, e.g. "xxHash(0x000000007fffffff)"
		
		// Get data from file
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: "alice29", ofType: "txt")!
		let data = NSData(contentsOfFile: path)
		let array = [UInt8](data! as Data)
		
		let bufSize = 1024
		var index = 0
		var flag = true
		
		
		repeat {
			// Prepare buffer
			var buf = [UInt8]()
			for _ in 0..<bufSize {
				buf.append(array[index])
				index += 1
				if index >= array.count {
					flag = false
					break
				}
			}
			
			// xxHash update
			xxh.update(buf)
			
		} while(flag)
		
		let hash = xxh.digest()
		print("xxHash64 Streaming -> 0x\(String(format: "%02lx", hash))")
	}
	
}

