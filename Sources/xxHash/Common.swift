//
//  Common.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/02/13.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import Foundation
import CoreFoundation

final class Common {
  
  // MARK: - Enum, Const
  enum Endian {
    case little
    case big
  }
  
  
  struct State<T: FixedWidthInteger> {
    var totalLen: T = 0
    var largeLen: Bool = false
    var v1: T = 0
    var v2: T = 0
    var v3: T = 0
    var v4: T = 0
    var mem = [UInt8](repeating: 0, count: MemoryLayout<T>.size * 4)
    var memSize: Int = 0
    var reserved: T = 0	// never read nor write, might be removed in a future version
  }
  
}



// MARK: - Utility
extension Common {
  
  static func endian() -> Endian {
    if CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) {
      return Endian.little
    }
    
    return Endian.big
  }
  
  
  static func rotl<T: FixedWidthInteger>(_ x: T, r: Int) -> T {
    return (x << r) | (x >> (T.bitWidth - r))
  }
  
}



// MARK: - Utility(Swap)
extension Common {
  
  static func swap<T: FixedWidthInteger>(_ x: T) -> T {
    var res: T = 0
    var mask: T = 0xff
    var bit = 0
    
    bit = (MemoryLayout<T>.size - 1) * 8
    for _ in 0..<MemoryLayout<T>.size / 2 {
      res |= (x & mask) << bit
      mask = mask << 8
      bit -= 16
    }
    
    bit = 8
    for _ in 0..<MemoryLayout<T>.size / 2 {
      res |= (x & mask) >> bit
      mask = mask << 8
      bit += 16
    }
    
    return res
  }
  
}



// MARK: - Utility(Convert)
extension Common {
  
  static func UInt8ArrayToUInt<T: FixedWidthInteger>(_ array: [UInt8], index: Int) -> T {
    var block: T = 0
    
    for i in 0..<MemoryLayout<T>.size {
      block |= T(array[index + i]) << (i * 8)
    }
    
    return block
  }
  
  static func UInt8ArrayToUInt<T: FixedWidthInteger>(_ array: [UInt8], index: Int, endian: Common.Endian) -> T {
    var block: T = UInt8ArrayToUInt(array, index: index)
    
    if endian == Common.Endian.little {
      return block
    }
    
    
    // Big Endian
    block = swap(block)
    
    return block
  }
  
  
  static private func UIntToUInt8Array<T: FixedWidthInteger>(_ block: T) -> [UInt8] {
    var array = [UInt8](repeating: 0, count: MemoryLayout<T>.size)
    var mask: T = 0xff
    
    for i in 0..<MemoryLayout<T>.size {
      array[i] = UInt8((block & mask) >> (i * 8))
      mask = mask << 8
    }
    
    return array
  }
  
  static func UIntToUInt8Array<T: FixedWidthInteger>(_ block: T, endian: Common.Endian) -> [UInt8] {
    var array = UIntToUInt8Array(block)
    
    if endian == Common.Endian.little {
      return array
    }
    
    
    // Big Endian
    array.reverse()
    
    return array
  }
  
  static func UInt32ToHex(_ val: UInt32) -> String {
    return String.init(format: "%08x", val)
  }
  
  static func UInt64ToHex(_ val: UInt64) -> String {
    return String.init(format: "%016lx", val)
  }
}
