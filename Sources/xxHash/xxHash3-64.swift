//
//  xxHash3-64.swift
//  xxHash
//
//  Created by Daisuke T on 2019/05/06.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

extension xxHash3 {
  
  /// XXH3 64bit class
  class Bit64 {
  }
  
}


// MARK: - Utility
extension xxHash3.Bit64 {
  
  static private func initKey(seed: UInt64, endian: Common.Endian) -> [UInt32] {
    var keySet2 = [UInt32](repeating: 0, count: xxHash3.Common.keySet.count)
    let seed1 = UInt32(seed & 0x00000000FFFFFFFF)
    let seed2 = UInt32(seed >> 32)
    
    for i in stride(from: 0, to: xxHash3.Common.keySetDefaultSize, by: 4) {
      keySet2[i + 0] = xxHash3.Common.keySet[i + 0] &+ seed1
      keySet2[i + 1] = xxHash3.Common.keySet[i + 1] &- seed2
      keySet2[i + 2] = xxHash3.Common.keySet[i + 2] &+ seed2
      keySet2[i + 3] = xxHash3.Common.keySet[i + 3] &- seed1
    }
    
    return keySet2
  }
  
  static private func len1To3(_ array: [UInt8], keySet: [UInt32], seed: UInt64) -> UInt64 {
    let c1 = UInt32(array[0])
    let c2 = UInt32(array[array.count >> 1])
    let c3 = UInt32(array[array.count - 1])
    let l1 = UInt32(c1 &+ (c2 << 8))
    let l2 = UInt32(UInt32(array.count) &+ (c3 << 2))
    let ll11: UInt64 =  xxHash3.Common.mult32To64(l1 &+ UInt32(seed) &+ keySet[0],
                                                  y: l2 &+ UInt32(seed >> 32) &+ keySet[1])
    
    return  xxHash3.Common.avalanche(ll11)
  }
  
  static private func len4To8(_ array: [UInt8], keySet: [UInt32], seed: UInt64, endian: Common.Endian) -> UInt64 {
    let in1: UInt32 = Common.UInt8ArrayToUInt(array, index: 0, endian: endian)
    let in2: UInt32 = Common.UInt8ArrayToUInt(array, index: array.count - 4, endian: endian)
    let in64: UInt64 = UInt64(UInt64(in1) &+ (UInt64(in2) << 32))
    let key = Common.UInt32ToUInt64(keySet[0], val2: keySet[1], endian: endian)
    let keyed: UInt64 = in64 ^ (key &+ seed)
    let mix64: UInt64 = UInt64(array.count) &+ xxHash3.Common.mul128Fold64(ll1: keyed, ll2: xxHash64.prime1)
    
    return xxHash3.Common.avalanche(mix64)
  }
  
  static private func len9To16(_ array: [UInt8], keySet: [UInt32], seed: UInt64, endian: Common.Endian) -> UInt64 {
    let key = Common.UInt32ToUInt64(keySet[0], val2: keySet[1], endian: endian)
    let key2 = Common.UInt32ToUInt64(keySet[2], val2: keySet[3], endian: endian)
    let ll1: UInt64 = Common.UInt8ArrayToUInt(array, index: 0, endian: endian) ^ (key &+ seed)
    let ll2: UInt64 = Common.UInt8ArrayToUInt(array, index: array.count - 8, endian: endian) ^ (key2 &- seed)
    let acc: UInt64 = UInt64(array.count) &+ (ll1 &+ ll2) &+ xxHash3.Common.mul128Fold64(ll1: ll1, ll2: ll2)
    
    return xxHash3.Common.avalanche(acc)
  }
  
  static private func len0To16(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> UInt64 {
    if array.count > 8 {
      return len9To16(array, keySet: xxHash3.Common.keySet, seed: seed, endian: endian)
    } else if array.count >= 4 {
      return len4To8(array, keySet: xxHash3.Common.keySet, seed: seed, endian: endian)
    } else if array.count > 0 {
      return len1To3(array, keySet: xxHash3.Common.keySet, seed: seed)
    }
    
    return seed
  }
  
  static private func hashLong(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> UInt64 {
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
    
    let keySet: [UInt32] = initKey(seed: seed, endian: endian)
    acc = xxHash3.Common.hashLong(acc, array: array, endian: endian)
    
    // converge into final hash
    return xxHash3.Common.mergeAccs(acc,
                                    keySet: keySet,
                                    start: UInt64(array.count) &* xxHash64.prime1,
                                    endian: endian)
  }
  
}


extension xxHash3.Bit64 {
  
  static func digest(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> UInt64 {
    if array.count <= 16 {
      return len0To16(array, seed: seed, endian: endian)
    }
    
    var acc = UInt64(UInt64(array.count) &* xxHash64.prime1)
    
    if array.count > 32 {
      
      if array.count > 64 {
        
        if array.count > 96 {
          
          if array.count > 128 {
            return hashLong(array, seed: seed, endian: endian)
          }
          
          acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(48)),
                                        keySet: [UInt32](xxHash3.Common.keySet.dropFirst(24)),
                                        seed: seed,
                                        endian: endian)
          
          acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(array.count - 64)),
                                        keySet: [UInt32](xxHash3.Common.keySet.dropFirst(28)),
                                        seed: seed,
                                        endian: endian)
        }
        
        acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(32)),
                                      keySet: [UInt32](xxHash3.Common.keySet.dropFirst(16)),
                                      seed: seed,
                                      endian: endian)
        
        acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(array.count - 48)),
                                      keySet: [UInt32](xxHash3.Common.keySet.dropFirst(20)),
                                      seed: seed,
                                      endian: endian)
      }
      
      acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(16)),
                                    keySet: [UInt32](xxHash3.Common.keySet.dropFirst(8)),
                                    seed: seed,
                                    endian: endian)
      
      acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(array.count - 32)),
                                    keySet: [UInt32](xxHash3.Common.keySet.dropFirst(12)),
                                    seed: seed,
                                    endian: endian)
    }
    
    acc &+= xxHash3.Common.mix16B(array,
                                  keySet: xxHash3.Common.keySet,
                                  seed: seed,
                                  endian: endian)
    
    acc &+= xxHash3.Common.mix16B([UInt8](array.dropFirst(array.count - 16)),
                                  keySet: [UInt32](xxHash3.Common.keySet.dropFirst(4)),
                                  seed: seed,
                                  endian: endian)
    
    return xxHash3.Common.avalanche(acc)
  }
  
}
