//
//  xxHash3Common.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/05/05.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import Foundation

class XXH3Common {
  
  // MARK: - Enum, Const
  static let keySetDefaultSize = 48 // minimum 32
  
  // swiftlint:disable comma
  static let keySet: [UInt32] = [
    0xb8fe6c39, 0x23a44bbe, 0x7c01812c, 0xf721ad1c,
    0xded46de9, 0x839097db, 0x7240a4a4, 0xb7b3671f,
    0xcb79e64e, 0xccc0e578, 0x825ad07d, 0xccff7221,
    0xb8084674, 0xf743248e, 0xe03590e6, 0x813a264c,
    0x3c2852bb, 0x91c300cb, 0x88d0658b, 0x1b532ea3,
    0x71644897, 0xa20df94e, 0x3819ef46, 0xa9deacd8,
    0xa8fa763f, 0xe39c343f, 0xf9dcbbc7, 0xc70b4f1d,
    0x8a51e04b, 0xcdb45931, 0xc89f7ec9, 0xd9787364,
    
    0xeac5ac83, 0x34d3ebc3, 0xc581a0ff, 0xfa1363eb,
    0x170ddd51, 0xb7f0da49, 0xd3165526, 0x29d4689e,
    0x2b16be58, 0x7d47a1fc, 0x8ff8b8d1, 0x7ad031ce,
    0x45cb3a8f, 0x95160428, 0xafd7fbca ,0xbb4b407e,
  ]
  // swiftlint:enable comma
  
  static let stripeLen = 64
  static let stripeElts = stripeLen / MemoryLayout<UInt32>.size
  static let accNB = stripeLen / MemoryLayout<UInt64>.size
  
}


// MARK: - Convert
extension XXH3Common {
  
  static func UInt32ArrayToUInt64Array(_ array: [UInt32]) -> [UInt64] {
    var array2 = [UInt64]()
    let endian = Common.endian()
    
    for i in 0..<array.count / 2 {
      if endian == .little {
        let h = UInt64(array[i * 2] << 32)
        let l = UInt64(array[i * 2 + 1])
        
        array2.append(h + l)
      } else {
        let h = UInt64(array[i * 2])
        let l = UInt64(array[i * 2 + 1] << 32)
        
        array2.append(h + l)
      }
    }
    
    return array2
  }
  
  static func UInt32ArrayToUInt8Array(_ array: [UInt32]) -> [UInt8] {
    var array2 = [UInt8]()
    let endian = Common.endian()
    
    for i in 0..<array.count {
      let arrayU8 = Common.UIntToUInt8Array(array[i], endian: endian)
      
      array2 += arrayU8
    }
    
    return array2
  }
  
}


// MARK: - Utility
extension XXH3Common {
  
  static func avalanche(_ h: UInt64) -> UInt64 {
    var h2 = h
    h2 ^= h2 >> 37
    h2 &*= xxHash64.prime3
    h2 ^= h2 >> 32
    
    return h2
  }
  
  static func mult32To64(_ x: UInt32, y: UInt32) -> UInt64 {
    return UInt64(UInt64(x) &* UInt64(y))
  }
  
  static func mul128Fold64(ll1: UInt64, ll2: UInt64) -> UInt64 {
    let h1 = UInt32(ll1 >> 32)
    let h2 = UInt32(ll2 >> 32)
    let l1 = UInt32(ll1 & 0x00000000FFFFFFFF)
    let l2 = UInt32(ll2 & 0x00000000FFFFFFFF)
    
    let llh: UInt64 = mult32To64(h1, y: h2)
    let llm1: UInt64 = mult32To64(l1, y: h2)
    let llm2: UInt64 = mult32To64(h1, y: l2)
    let lll: UInt64 = mult32To64(l1, y: l2)
    
    let t = UInt64(lll &+ (llm1 << 32))
    let carry1 = UInt64((t < lll) ? 1 : 0)
    
    let lllow = UInt64(t &+ (llm2 << 32))
    let carry2 = UInt64((lllow < t) ? 1 : 0)
    
    let llm1l = UInt64(llm1 >> 32)
    let llm2l = UInt64(llm2 >> 32)
    
    let llhigh = UInt64(llh &+ llm1l &+ llm2l &+ carry1 &+ carry2)
    
    return llhigh ^ lllow
  }
  
  static private func accumulate512(_ acc: [UInt64], array: [UInt8], keySet: [UInt32], endian: Common.Endian) -> [UInt64] {
    var acc2 = acc
    
    for i in 0..<accNB {
      let dataVal: UInt64 = Common.UInt8ArrayToUInt(array, index: i * 2, endian: endian)
      let keyVal = UInt64(keySet[i * 2])
      let dataKey = UInt64(keyVal ^ dataVal)
      acc2[i] = mult32To64(UInt32(dataKey & 0x00000000FFFFFFFF), y: UInt32(dataKey >> 32))
      acc2[i] &+= dataVal
    }
    
    return acc2
  }
  
  static private func accumulate(_ acc: [UInt64], array: [UInt8], keySet: [UInt32], nbStripes: Int, endian: Common.Endian) -> [UInt64] {
    var acc2 = acc
    
    for i in 0..<nbStripes {
      acc2 = accumulate512(acc2,
                           array: [UInt8](array[i * stripeLen..<array.count]),
                           keySet: [UInt32](keySet[i * 2..<keySet.count]),
                           endian: endian)
    }
    
    return acc2
  }
  
  static private func scrambleAcc(_ acc: [UInt64], keySet: [UInt32]) -> [UInt64] {
    var acc2 = acc
    
    for i in 0..<accNB {
      let key64 = UInt64(keySet[i * 2])
      var acc64 = acc[i]
      acc64 ^= acc64 >> 47
      acc64 ^= key64
      acc64 &*= UInt64(xxHash32.prime1)
      acc2[i] = acc64
    }
    
    return acc2
  }
  
  static func hashLong(_ acc: [UInt64], array: [UInt8], endian: Common.Endian) -> [UInt64] {
    let nbKeys = (keySetDefaultSize - stripeLen) / 2
    let blockLen = stripeLen * nbKeys
    let nbBlocks = array.count / blockLen
    var acc2 = acc
    
    for i in 0..<nbBlocks {
      acc2 = accumulate(acc2,
                        array: [UInt8](array[i * blockLen..<array.count]),
                        keySet: keySet,
                        nbStripes: nbKeys,
                        endian: endian)
      
      acc2 = scrambleAcc(acc2,
                         keySet: [UInt32](keySet[keySetDefaultSize - stripeElts..<keySet.count]))
    }
    
    
    // last partial block
    let nbStripes = (array.count % blockLen) / stripeLen
    acc2 = accumulate(acc2,
                      array: [UInt8](array[nbBlocks * blockLen..<array.count]),
                      keySet: keySet,
                      nbStripes: nbStripes, endian: endian)
    
    // last stripe
    if array.count & (stripeLen - 1) > 0 {
      acc2 = accumulate512(acc2,
                           array: [UInt8](array[array.count - stripeLen..<array.count]),
                           keySet: [UInt32](keySet[nbStripes * 2..<keySet.count]),
                           endian: endian)
    }
    
    return acc2
  }
  
  static private func mix2Accs(_ acc: [UInt64], keySet: [UInt64]) -> UInt64 {
    return mul128Fold64(ll1: acc[0] ^ keySet[0], ll2: acc[1] ^ keySet[1])
  }
  
  static func mergeAccs(_ acc: [UInt64], keySet: [UInt64], start: UInt64) -> UInt64 {
    var result: UInt64 = start
    
    result &+= mix2Accs(acc, keySet: keySet)
    result &+= mix2Accs([UInt64](acc[2..<acc.count]), keySet: [UInt64](keySet[4..<keySet.count]))
    result &+= mix2Accs([UInt64](acc[4..<acc.count]), keySet: [UInt64](keySet[8..<keySet.count]))
    result &+= mix2Accs([UInt64](acc[6..<acc.count]), keySet: [UInt64](keySet[12..<keySet.count]))
    
    return avalanche(result)
  }
  
  static func mix16B(_ array: [UInt8], keySet: [UInt64], seed: UInt64, endian: Common.Endian) -> UInt64 {
    let ll1: UInt64 = Common.UInt8ArrayToUInt(array, index: 0, endian: endian)
    let ll2: UInt64 = Common.UInt8ArrayToUInt(array, index: 8, endian: endian)
    
    return mul128Fold64(ll1: ll1 ^ keySet[0] &+ seed,
                        ll2: ll2 ^ keySet[1] &+ seed)
  }
  
}
