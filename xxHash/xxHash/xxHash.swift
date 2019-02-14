//
//  xxHash.swift
//  xxHash
//
//  Created by Daisuke T on 2019/02/13.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

// TODO: hash64
// TODO: overload func(string, data)
// TODO: iOS scheme
// TODO: tvOS scheme
// TODO: demo

// TODO: unittest
// TODO: travis

// TODO: podspec
// TODO: cocoapods

// TODO: readme
// TODO: header image

class xxHash {

	// MARK: - Enum, Const
	enum Endian {
		case Little
		case Big
	}

	
	struct State<T: FixedWidthInteger> {
		var totalLen: T = 0
		var largeLen: Bool = false
		var v1: T = 0
		var v2: T = 0
		var v3: T = 0
		var v4: T = 0
		var mem = [UInt8](repeating: 0, count: MemoryLayout<T>.size * 4)
		var memsize: Int = 0
		var reserved: T = 0	// never read nor write, might be removed in a future version
	}

}



// MARK: - Utility
extension xxHash {

	static func endian() -> Endian {
		if CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) {
			return Endian.Little
		}
		
		return Endian.Big
	}

	
	static func rotl<T: FixedWidthInteger>(_ x: T, r: Int) -> T {
		return (x << r) | (x >> (T.bitWidth - r))
	}


	static func swap<T: FixedWidthInteger>(_ x: T) -> T {
		var res = T(0)
		var mask = T(0xff)
		var bit = 0
		
		bit = (MemoryLayout<T>.size - 1) * 8
		for _ in 0..<MemoryLayout<T>.size / 2 {
			res |= (x & mask) << bit
			mask = mask << 2
			bit -= 16
		}
		
		bit = 8
		for _ in 0..<MemoryLayout<T>.size / 2 {
			res |= (x & mask) >> bit
			mask = mask << 2
			bit += 16
		}
		
		return res
	}
	
	static func swap(_ x: [UInt8]) -> [UInt8] {
		var res = [UInt8](repeating: 0, count: x.count)
		
		for i in 0..<x.count {
			res[i] = x[x.count - (i + 1)]
		}
		
		return res
	}


	static func UInt8ArrayToUInt<T: FixedWidthInteger>(_ array: [UInt8], index: Int, type: T) -> T {
		var block = T(0)
		var index2 = 0
		
		for i in 0..<MemoryLayout<T>.size {
			index2 = index * MemoryLayout<T>.size + i
			block |= T(array[index2]) << (i * 8)
		}
		
		return block
	}
	
	static func UInt8ArrayToUInt<T: FixedWidthInteger>(_ array: [UInt8], index: Int, type: T, endian: xxHash.Endian) -> T {
		var block = UInt8ArrayToUInt(array, index: index, type: type)
		
		if(endian == xxHash.Endian.Little) {
			return block
		}
		
		
		// Big Endian
		block = swap(block)
		
		return block
	}
	
	
	static func UIntToUInt8Array<T: FixedWidthInteger>(_ block: T) -> [UInt8] {
		var array = [UInt8](repeating: 0, count: MemoryLayout<T>.size)
		var mask = T(0xff)
		
		for i in 0..<MemoryLayout<T>.size {
			array[i] = UInt8((block & mask) >> (i * 8))
			mask = mask << 2
		}
		
		return array
	}
	
	static func UIntToUInt8Array<T: FixedWidthInteger>(_ block: T, endian: xxHash.Endian) -> [UInt8] {
		var array = UIntToUInt8Array(block)
		
		if(endian == xxHash.Endian.Little) {
			return array
		}
		
		
		// Big Endian
		array = swap(array)
		
		return array
	}

}
