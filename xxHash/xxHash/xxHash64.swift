//
//  xxHash64.swift
//  xxHash
//
//  Created by Daisuke T on 2019/02/12.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

public class xxHash64 {

	// MARK: - Enum, Const
	static let prime1: UInt64 = 11400714785074694791	// 0b1001111000110111011110011011000110000101111010111100101010000111
	static let prime2: UInt64 = 14029467366897019727	// 0b1100001010110010101011100011110100100111110101001110101101001111
	static let prime3: UInt64 =  1609587929392839161	// 0b0001011001010110011001111011000110011110001101110111100111111001
	static let prime4: UInt64 =  9650029242287828579	// 0b1000010111101011110010100111011111000010101100101010111001100011
	static let prime5: UInt64 =  2870177450012600261	// 0b0010011111010100111010110010111100010110010101100110011111000101


	
	// MARK: - Member
	private let endian = xxHash.endian()
	private var state = xxHash.State<UInt64>()
	public var seed = UInt64(0) {
		didSet {
			// reset()
		}
	}



	// MARK: - Life cycle
	init(_ seed: UInt64 = 0) {
		self.seed = seed
	}

}



// MARK: - Utility
public extension xxHash64 {

	static private func round(_ acc: UInt64, input: UInt64) -> UInt64 {
		var acc2 = acc
		acc2 &+= input &* prime2
		acc2 = xxHash.rotl(acc2, r: 31)
		acc2 &*= prime1

		return acc2
	}

	static private func mergeRound(_ acc: UInt64, val: UInt64) -> UInt64 {
		let val2 = round(0, input: val)
		var acc2 = acc ^ val2
		acc2 = acc2 &* prime1 + prime4

		return acc2
	}

	static private func avalanche(_ h: UInt64) -> UInt64 {
		var h2 = h
		h2 ^= h2 >> 33
		h2 &*= prime2
		h2 ^= h2 >> 29
		h2 &*= prime3
		h2 ^= h2 >> 32

		return h2
	}
}
