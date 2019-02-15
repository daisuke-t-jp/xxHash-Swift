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
	private let endian = Common.endian()
	private var state = Common.State<UInt64>()
	public var seed = UInt64(0) {
		didSet {
			reset()
		}
	}



	// MARK: - Life cycle
	init(_ seed: UInt64 = 0) {
		self.seed = seed
		reset()
	}

}



// MARK: - Utility
public extension xxHash64 {

	static private func round(_ acc: UInt64, input: UInt64) -> UInt64 {
		var acc2 = acc
		acc2 &+= input &* prime2
		acc2 = Common.rotl(acc2, r: 31)
		acc2 &*= prime1

		return acc2
	}

	static private func mergeRound(_ acc: UInt64, val: UInt64) -> UInt64 {
		let val2 = round(0, input: val)
		var acc2 = acc ^ val2
		acc2 = acc2 &* prime1 &+ prime4

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



// MARK: - Finalize
public extension xxHash64 {
	
	static private func finalize(_ h: UInt64, array: [UInt8], len: Int, endian: Common.Endian) -> UInt64 {
		var index = 0
		var h2 = h
		
		func process1() {
			h2 ^= UInt64(array[index]) &* prime5
			index += 1
			h2 = Common.rotl(h2, r: 11) &* prime1
		}
		
		func process4() {
			h2 ^= UInt64(Common.UInt8ArrayToUInt(array, index: index, type: UInt32(0), endian: endian)) &* prime1
			index += 4
			h2 = Common.rotl(h2, r: 23) &* prime2 &+ prime3
		}

		func process8() {
			let k1 = round(0, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0), endian: endian))
			index += 8
			h2 ^= k1
			h2 = Common.rotl(h2, r: 27) &* prime1 &+ prime4
		}
		
		
		switch len & 31 {
		case 24:
			process8()
			fallthrough
			
		case 16:
			process8()
			fallthrough
			
		case 8:
			process8()
			return avalanche(h2)
			
			
		case 28:
			process8()
			fallthrough
			
		case 20:
			process8()
			fallthrough
			
		case 12:
			process8()
			fallthrough

		case 4:
			process4()
			return avalanche(h2)
			
			
		case 25:
			process8()
			fallthrough
			
		case 17:
			process8()
			fallthrough
			
		case 9:
			process8()
			process1()
			return avalanche(h2)
			
			
		case 29:
			process8()
			fallthrough
			
		case 21:
			process8()
			fallthrough
			
		case 13:
			process8()
			fallthrough
			
		case 5:
			process4()
			process1()
			return avalanche(h2)


		case 26:
			process8()
			fallthrough
			
		case 18:
			process8()
			fallthrough
			
		case 10:
			process8()
			process1()
			process1()
			return avalanche(h2)
			

		case 30:
			process8()
			fallthrough
			
		case 22:
			process8()
			fallthrough
			
		case 14:
			process8()
			fallthrough
			
		case 6:
			process4()
			process1()
			process1()
			return avalanche(h2)
			
			
		case 27:
			process8()
			fallthrough
			
		case 19:
			process8()
			fallthrough
			
		case 11:
			process8()
			process1()
			process1()
			process1()
			return avalanche(h2)


		case 31:
			process8()
			fallthrough

		case 23:
			process8()
			fallthrough
			
		case 15:
			process8()
			fallthrough

		case 7:
			process4()
			fallthrough
			
		case 3:
			process1()
			fallthrough

		case 2:
			process1()
			fallthrough
			
		case 1:
			process1()
			fallthrough
			
		case 0:
			return avalanche(h2)


		default:
			break
		}
		
		return 0	// unreachable, but some compilers complain without it
	}
	
}



// MARK: - Digest(One-shot)
public extension xxHash64 {
	
	static private func digest(_ array: [UInt8], seed: UInt64, endian: Common.Endian) -> UInt64 {
		
		let len = array.count
		var h = UInt64(0)
		var index = 0

		if len >= 32 {
			let limit = len - 32
			var v1 = seed &+ prime1 &+ prime2
			var v2 = seed &+ prime2
			var v3 = seed + 0
			var v4 = seed &- prime1
			
			repeat {
				
				v1 = round(v1, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0)))
				index += 8
				
				v2 = round(v2, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0)))
				index += 8
				
				v3 = round(v3, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0)))
				index += 8
				
				v4 = round(v4, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0)))
				index += 8
				
			} while(index < limit)
			
			h = Common.rotl(v1, r: 1)  &+
				Common.rotl(v2, r: 7)  &+
				Common.rotl(v3, r: 12) &+
				Common.rotl(v4, r: 18)

			h = mergeRound(h, val: v1)
			h = mergeRound(h, val: v2)
			h = mergeRound(h, val: v3)
			h = mergeRound(h, val: v4)
		}
		else {
			h = seed &+ prime5
		}
		
		h &+= UInt64(len)
		
		let array2 = Array(array[index...])
		h = finalize(h, array: array2, len: len, endian: endian)
		
		return h
	}
	
	static public func digest(_ array: [UInt8], seed: UInt64 = 0) -> UInt64 {
		return digest(array, seed: seed, endian: Common.endian())
	}

	static public func digest(_ string: String, seed: UInt64 = 0) -> UInt64 {
		return digest(Array(string.utf8), seed: seed, endian: Common.endian())
	}
	
	static public func digest(_ data: Data, seed: UInt64 = 0) -> UInt64 {
		return digest([UInt8](data), seed: seed, endian: Common.endian())
	}
}



// MARK: - Digest(Streaming)
public extension xxHash64 {
	
	public func reset() {
		state = Common.State()
		
		state.v1 = seed &+ xxHash64.prime1 &+ xxHash64.prime2
		state.v2 = seed &+ xxHash64.prime2
		state.v3 = seed + 0
		state.v4 = seed &- xxHash64.prime1
	}

	
	public func update(_ array: [UInt8]) {
		let len = array.count
		var index = 0
		
		state.totalLen += UInt64(len)
		
		if state.memsize + len < 32 {
			
			// fill in tmp buffer
			for i in 0..<len {
				state.mem[state.memsize + i] = array[i]
			}
			
			state.memsize += len
			
			return
		}
		
		
		if state.memsize > 0 {
			// some data left from previous update
			for i in 0..<32 - state.memsize {
				state.mem[state.memsize + i] = array[i]
			}
			
			state.v1 = xxHash64.round(state.v1, input: Common.UInt8ArrayToUInt(state.mem, index: 0, type: UInt64(0), endian: endian))
			state.v2 = xxHash64.round(state.v2, input: Common.UInt8ArrayToUInt(state.mem, index: 8, type: UInt64(0), endian: endian))
			state.v3 = xxHash64.round(state.v3, input: Common.UInt8ArrayToUInt(state.mem, index: 16, type: UInt64(0), endian: endian))
			state.v4 = xxHash64.round(state.v4, input: Common.UInt8ArrayToUInt(state.mem, index: 24, type: UInt64(0), endian: endian))
			
			index += 32 - state.memsize
			state.memsize = 0
		}

		if index + 32 <= len {
			
			let limit = len - 32
			var v1 = state.v1
			var v2 = state.v2
			var v3 = state.v3
			var v4 = state.v4
			
			repeat {
				
				v1 = xxHash64.round(v1, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0), endian: endian))
				index += 8
				
				v2 = xxHash64.round(v2, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0), endian: endian))
				index += 8
				
				v3 = xxHash64.round(v3, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0), endian: endian))
				index += 8
				
				v4 = xxHash64.round(v4, input: Common.UInt8ArrayToUInt(array, index: index, type: UInt64(0), endian: endian))
				index += 8
				
			} while (index <= limit)
			
			state.v1 = v1
			state.v2 = v2
			state.v3 = v3
			state.v4 = v4
			
		}
		
		
		if index < len {
			for i in 0..<len - index {
				state.mem[i] = array[index + i]
			}
			
			state.memsize = len - index
		}
		
	}

	public func update(_ string: String) {
		return update(Array(string.utf8))
	}
	
	public func update(_ data: Data) {
		return update([UInt8](data))
	}


	public func digest() -> UInt64 {
		var h = UInt64(0)
		
		if state.totalLen >= 32 {
			h = Common.rotl(state.v1, r: 1)  &+
				Common.rotl(state.v2, r: 7)  &+
				Common.rotl(state.v3, r: 12) &+
				Common.rotl(state.v4, r: 18)

			h = xxHash64.mergeRound(h, val: state.v1)
			h = xxHash64.mergeRound(h, val: state.v2)
			h = xxHash64.mergeRound(h, val: state.v3)
			h = xxHash64.mergeRound(h, val: state.v4)

		}
		else {
			h = state.v3 /* == seed */ &+ xxHash64.prime5
		}
		
		h &+= state.totalLen
		
		h = xxHash64.finalize(h, array: state.mem, len: state.memsize, endian: endian)
		
		return h
	}
	
}



// MARK: - Canonical
public extension xxHash64 {
	
	static private func canonicalFromHash(_ hash: UInt64, endian: Common.Endian) -> [UInt8] {
		var hash2 = hash
		if endian == Common.Endian.Little {
			hash2 = Common.swap(hash2)
		}

		return Common.UIntToUInt8Array(hash2, endian: endian)
	}
	
	static public func canonicalFromHash(_ hash: UInt64) -> [UInt8] {
		return canonicalFromHash(hash, endian: Common.endian())
	}
	
	
	static private func hashFromCanonical(_ canonical: [UInt8], endian: Common.Endian) -> UInt64 {
		var hash = Common.UInt8ArrayToUInt(canonical, index: 0, type: UInt64(0), endian: endian)
		if endian == Common.Endian.Little {
			hash = Common.swap(hash)
		}
		
		return hash
	}
	
	static public func hashFromCanonical(_ canonical: [UInt8]) -> UInt64 {
		return hashFromCanonical(canonical, endian: Common.endian())
	}
	
}
