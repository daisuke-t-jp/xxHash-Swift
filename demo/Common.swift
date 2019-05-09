//
//  Common.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/02/14.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import Foundation

import xxHash_Swift

class Common {
  
  /**
   * Generate Hash(One-shot)
   *
   * 32bit Version
   */
  static func oneshot32() {
    do {
      let hash = xxHash32.digest("123456789ABCDEF")
      print("xxHash32 One-shot -> 0x\(String(format: "%08x", hash))")
    }
    
    do {
      let hash = xxHash32.digest("123456789ABCDEF", seed: 0x7fffffff)
      print("xxHash32 One-shot(0x7fffffff) -> 0x\(String(format: "%08x", hash))")
    }
  }
  
  /**
   * Generate Hash(One-shot)
   *
   * 64bit Version
   */
  static func oneshot64() {
    do {
      let hash = xxHash64.digest("123456789ABCDEF")
      print("xxHash64 One-shot -> 0x\(String(format: "%016lx", hash))")
    }
    
    do {
      let hash = xxHash64.digest("123456789ABCDEF", seed: 0x000000007fffffff)
      print("xxHash64 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx", hash))")
    }
  }
  
  /**
   * Generate Hash(One-shot)
   *
   * XXH3 64bit Version
   */
  static func oneshot3_64() {
    do {
      let hash = xxHash3.digest64("123456789ABCDEF")
      print("xxHash3-64 One-shot -> 0x\(String(format: "%016lx", hash))")
    }
    
    do {
      let hash = xxHash3.digest64("123456789ABCDEF", seed: 0x000000007fffffff)
      print("xxHash3-64 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx", hash))")
    }
  }
  
  /**
   * Generate Hash(One-shot)
   *
   * XXH3 128bit Version
   */
  static func oneshot3_128() {
    do {
      let hash = xxHash3.digest128("123456789ABCDEF")
      print("xxHash3-128 One-shot -> 0x\(String(format: "%016lx%016lx", hash[0], hash[1]))")
    }
    
    do {
      let hash = xxHash3.digest128("123456789ABCDEF", seed: 0x000000007fffffff)
      print("xxHash3-128 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx%016lx", hash[0], hash[1]))")
    }
  }
  
  
  /**
   * Generate Hash(Streaming)
   *
   * 32bit Version
   */
  static func streaming32() {
    let xxh = xxHash32() // if using seed, e.g. "xxHash(0x7fffffff)"
    
    // Get data from file
    let bundle = Bundle(for: Common.self)
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    let hash = xxh.digest()
    print("xxHash32 Streaming -> 0x\(String(format: "%08x", hash))")
  }
  
  /**
   * Generate Hash(Streaming)
   *
   * 64bit Version
   */
  static func streaming64() {
    let xxh = xxHash64() // if using seed, e.g. "xxHash(0x000000007fffffff)"
    
    // Get data from file
    let bundle = Bundle(for: Common.self)
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    let hash = xxh.digest()
    print("xxHash64 Streaming -> 0x\(String(format: "%016lx", hash))")
  }
  
}

