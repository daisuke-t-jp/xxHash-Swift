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
  
  // MARK: - One-shot
  static func oneshotXXH32() {
    do {
      let hash = XXH32.digest("123456789ABCDEF")
      print("XXH32 One-shot -> 0x\(String(format: "%08x", hash))")
    }
    
    do {
      let hash = XXH32.digest("123456789ABCDEF", seed: 0x7fffffff)
      print("XXH32 One-shot(0x7fffffff) -> 0x\(String(format: "%08x", hash))")
    }
  }
  
  static func oneshotXXH64() {
    do {
      let hash = XXH64.digest("123456789ABCDEF")
      print("XXH64 One-shot -> 0x\(String(format: "%016lx", hash))")
    }
    
    do {
      let hash = XXH64.digest("123456789ABCDEF", seed: 0x000000007fffffff)
      print("XXH64 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx", hash))")
    }
  }
  
  static func oneshotXXH3_64() {
    do {
      let hash = XXH3.digest64("123456789ABCDEF")
      print("XXH3-64 One-shot -> 0x\(String(format: "%016lx", hash))")
    }
    
    do {
      let hash = XXH3.digest64("123456789ABCDEF", seed: 0x000000007fffffff)
      print("XXH3-64 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx", hash))")
    }
  }
  
  static func oneshotXXH3_128() {
    do {
      let hash = XXH3.digest128("123456789ABCDEF")
      print("XXH3-128 One-shot -> 0x\(String(format: "%016lx%016lx", hash[0], hash[1]))")
    }
    
    do {
      let hash = XXH3.digest128("123456789ABCDEF", seed: 0x000000007fffffff)
      print("XXH3-128 One-shot(0x000000007fffffff) -> 0x\(String(format: "%016lx%016lx", hash[0], hash[1]))")
    }
  }
  
  
  // MARK: - Streaming
  static func streamingXXH32() {
    // Create xxHash instance
    let xxh = XXH32() // if using seed, e.g. "XXH32(0x7fffffff)"
    
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
    print("XXH32 Streaming -> 0x\(String(format: "%08x", hash))")
  }
  
  static func streamingXXH64() {
    // Create xxHash instance
    let xxh = XXH64() // if using seed, e.g. "XXH64(0x000000007fffffff)"
    
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
    print("XXH64 Streaming -> 0x\(String(format: "%016lx", hash))")
  }
  
}

