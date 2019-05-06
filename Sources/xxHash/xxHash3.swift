//
//  xxHash3.swift
//  xxHash
//
//  Created by Daisuke T on 2019/05/06.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

/// xxHash3 class
typealias XXH3 = xxHash3
public class xxHash3 {
  
}


// MARK: - 64 bit
extension xxHash3 {
  
  static public func digest64(_ array: [UInt8], seed: UInt64 = 0) -> UInt64 {
    return xxHash3.Bit64.digest(array, seed: seed, endian: Common.endian())
  }
  
  static public func digest64(_ string: String, seed: UInt64 = 0) -> UInt64 {
    return xxHash3.Bit64.digest(Array(string.utf8), seed: seed, endian: Common.endian())
  }
  
  static public func digest64(_ data: Data, seed: UInt64 = 0) -> UInt64 {
    return xxHash3.Bit64.digest([UInt8](data), seed: seed, endian: Common.endian())
  }

}


// MARK: - 128 bit
extension xxHash3 {
  
  static public func digest128(_ array: [UInt8], seed: UInt64 = 0) -> [UInt64] {
    return xxHash3.Bit128.digest(array, seed: seed, endian: Common.endian())
  }
  
  static public func digest128(_ string: String, seed: UInt64 = 0) -> [UInt64] {
    return xxHash3.Bit128.digest(Array(string.utf8), seed: seed, endian: Common.endian())
  }
  
  static public func digest128(_ data: Data, seed: UInt64 = 0) -> [UInt64] {
    return xxHash3.Bit128.digest([UInt8](data), seed: seed, endian: Common.endian())
  }
  
}
