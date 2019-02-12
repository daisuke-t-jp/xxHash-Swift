//
//  xxHash32.swift
//  xxHash
//
//  Created by Daisuke T on 2019/02/12.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation


// TODO: gitignore
// TODO: base class
// TODO: travis
// TODO: podspec
// TODO: readme
// TODO: cocoapods
// TODO: unittest
// TODO: test
// TODO: iOS scheme
// TODO: tvOS scheme
// TODO: demo
// TODO: hash32
// TODO: hash64

public class xxHash32 {

	// MARK: - Enum, Const
	static let prime1: UInt32 = 2654435761	// 0b10011110001101110111100110110001
	static let prime2: UInt32 = 2246822519	// 0b10000101111010111100101001110111
	static let prime3: UInt32 = 3266489917	// 0b11000010101100101010111000111101
	static let prime4: UInt32 = 668265263	// 0b00100111110101001110101100101111
	static let prime5: UInt32 = 374761393	// 0b00010110010101100110011110110001

	private enum Endian {
		case Little
		case Big
	}
	
	
	
	// MARK: - Utility
	static private func rotl<T: FixedWidthInteger>(_ x: T, r: Int) -> T {
		return (x << r) | (x >> (T.bitWidth - r))
	}

	static private func swap32(_ x: UInt32) -> UInt32 {
		var res = UInt32(0)

		res |= (x << 24) & 0xff000000
		res |= (x << 8)  & 0x00ff0000
		res |= (x >> 8)  & 0x0000ff00
		res |= (x >> 24) & 0x000000ff

		return res
	}

	static private func round(_ seed: UInt32, input: UInt32) -> UInt32 {

		var seed2 = seed
		seed2 += input * prime2
		seed2 = rotl(seed, r: 13)
		seed2 *= prime1

		return seed2
	}
	
	static private func avalanche(_ h32: UInt32) -> UInt32 {

		var h32_2 = h32
		h32_2 ^= h32_2 >> 15;
		h32_2 *= prime2;
		h32_2 ^= h32_2 >> 13;
		h32_2 *= prime3;
		h32_2 ^= h32_2 >> 16;

		return h32_2
	}
	
	static private func endian() -> Endian {
		if CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) {
			return Endian.Little
		}
	
		return Endian.Big
	}
	

}
