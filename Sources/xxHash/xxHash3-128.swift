//
//  xxHash3-128.swift
//  xxHash
//
//  Created by Daisuke T on 2019/05/06.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

extension xxHash3 {
  
  /// XXH3 128bit class
  class Bit128 {
  }
  
}


// MARK: - Utility
extension xxHash3.Bit128 {
  
  static private func len1To3(_ array: [UInt8], keySet: [UInt32], seed: UInt64) -> [UInt64] {
    let c1 = UInt32(array[0])
    let c2 = UInt32(array[array.count >> 1])
    let c3 = UInt32(array[array.count - 1])
    let l1 = UInt32(c1 &+ (c2 << 8))
    let l2 = UInt32(UInt32(array.count) &+ (c3 << 2))
    let ll11 = XXH3Common.mult32To64(l1 &+ UInt32(seed) &+ keySet[0],
                                     y: l2 &+ keySet[1])
    let ll12 = XXH3Common.mult32To64(l1 &+ keySet[2],
                                     y: l2 &- UInt32(seed) &+ keySet[3])
    
    let h128 = [
      XXH3Common.avalanche(ll11),
      XXH3Common.avalanche(ll12)
    ]
    
    return h128
  }
  
  static private func len4To8(_ array: [UInt8], keySet: [UInt32], seed: UInt64, endian: Common.Endian) -> [UInt64] {
    let l1: UInt32 = Common.UInt8ArrayToUInt(array, index: 0, endian: endian) &+ UInt32(seed) &+ keySet[0]
    let l2: UInt32 = Common.UInt8ArrayToUInt(array, index: array.count - 4, endian: endian) &+ UInt32(seed >> 32) &+ keySet[1]
    let acc1: UInt64 = UInt64(array.count) &+ UInt64(l1) &+ (UInt64(l2) << 32) &+ XXH3Common.mult32To64(l1, y: l2)
    let acc2: UInt64 = UInt64(array.count) &* xxHash64.prime1 &+ UInt64(l1) &* xxHash64.prime2 &+ UInt64(l2) &* xxHash64.prime3
    
    let h128 = [
      XXH3Common.avalanche(acc1),
      XXH3Common.avalanche(acc2)
    ]
    
    return h128
  }
  
  static private func len9To16(_ array: [UInt8], keySet: [UInt32], seed: UInt64, endian: Common.Endian) -> [UInt64] {
    let keySet64 = XXH3Common.UInt32ArrayToUInt64Array(keySet)
    
    var acc1: UInt64 = xxHash64.prime1 &* (UInt64(array.count) &+ seed)
    var acc2: UInt64 = xxHash64.prime2 &* (UInt64(array.count) &- seed)
    let ll1: UInt64 = Common.UInt8ArrayToUInt(array, index: 0, endian: endian)
    let ll2: UInt64 = Common.UInt8ArrayToUInt(array, index: array.count - 8, endian: endian)
    acc1 &+= XXH3Common.mul128Fold64(ll1: ll1 &+ keySet64[0], ll2: ll2 &+ keySet64[1])
    acc2 &+= XXH3Common.mul128Fold64(ll1: ll1 &+ keySet64[2], ll2: ll2 &+ keySet64[3])
    
    let h128 = [
      XXH3Common.avalanche(acc1),
      XXH3Common.avalanche(acc2)
    ]
    
    return h128
  }
  
  static private func len0To16(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> [UInt64] {
    if array.count > 8 {
      return len9To16(array, keySet: XXH3Common.keySet, seed: seed, endian: endian)
    } else if array.count >= 4 {
      return len4To8(array, keySet: XXH3Common.keySet, seed: seed, endian: endian)
    } else if array.count > 0 {
      return len1To3(array, keySet: XXH3Common.keySet, seed: seed)
    }
    
    let h128: [UInt64] = [
      seed,
      0 &- seed
    ]
    
    return h128
  }
  
  static private func hashLong(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> [UInt64] {
    var acc: [UInt64] = [
      seed,
      xxHash64.prime1,
      xxHash64.prime2,
      xxHash64.prime3,
      xxHash64.prime4,
      xxHash64.prime5,
      UInt64(0 &- seed),
      0
    ]
    
    let keySet64 = XXH3Common.UInt32ArrayToUInt64Array(XXH3Common.keySet)
    acc = XXH3Common.hashLong(acc, array: array, endian: endian)
    
    
    // converge into final hash
    let low64: UInt64 = XXH3Common.mergeAccs(acc,
                                             keySet: keySet64,
                                             start: UInt64(array.count) &* xxHash64.prime1)
    let high64: UInt64 = XXH3Common.mergeAccs(acc,
                                              keySet: [UInt64](keySet64.dropFirst(16)),
                                              start: UInt64(array.count + 1) &* xxHash64.prime2)
    
    let h128 = [low64, high64]
    
    return h128
  }
  
}


extension xxHash3.Bit128 {
  
  static func digest(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> [UInt64] {
    if array.count <= 16 {
      return len0To16(array, seed: seed, endian: endian)
    }
    
    let keySet64 = XXH3Common.UInt32ArrayToUInt64Array(XXH3Common.keySet)
    var acc: UInt64 = xxHash64.prime1 &* (UInt64(array.count) &* xxHash64.prime1)
    var acc2: UInt64 = 0
    
    if array.count > 32 {
      
      if array.count > 64 {
        
        if array.count > 96 {
          
          if array.count > 128 {
            return hashLong(array, seed: seed, endian: endian)
          }
          
          acc &+= XXH3Common.mix16B([UInt8](array.dropFirst(48)),
                                    keySet: [UInt64](keySet64.dropFirst(96)),
                                    seed: seed,
                                    endian: endian)
          
          acc2 &+= XXH3Common.mix16B([UInt8](array.dropFirst(array.count - 64)),
                                     keySet: [UInt64](keySet64.dropFirst(112)),
                                     seed: seed,
                                     endian: endian)
        }
        
        acc &+= XXH3Common.mix16B([UInt8](array.dropFirst(32)),
                                  keySet: [UInt64](keySet64.dropFirst(64)),
                                  seed: seed,
                                  endian: endian)
        
        acc2 &+= XXH3Common.mix16B([UInt8](array.dropFirst(array.count - 48)),
                                   keySet: [UInt64](keySet64.dropFirst(80)),
                                   seed: seed,
                                   endian: endian)
      }
      
      acc &+= XXH3Common.mix16B([UInt8](array.dropFirst(16)),
                                keySet: [UInt64](keySet64.dropFirst(32)),
                                seed: seed,
                                endian: endian)
      
      acc2 &+= XXH3Common.mix16B([UInt8](array.dropFirst(array.count - 32)),
                                 keySet: [UInt64](keySet64.dropFirst(48)),
                                 seed: seed,
                                 endian: endian)
    }
    
    acc &+= XXH3Common.mix16B(array,
                              keySet: keySet64,
                              seed: seed,
                              endian: endian)
    
    acc2 &+= XXH3Common.mix16B([UInt8](array.dropFirst(array.count - 16)),
                               keySet: [UInt64](keySet64.dropFirst(16)),
                               seed: seed,
                               endian: endian)
    
    let part1 = acc &+ acc2
    let part2 = (acc &* xxHash64.prime3) &+ (acc2 &* xxHash64.prime4) &+ (UInt64(UInt64(array.count) &- seed) &* xxHash64.prime2)
    
    let h128 = [
      XXH3Common.avalanche(part1),
      0 &- XXH3Common.avalanche(part2)
    ]
    
    return h128
  }
  
}
