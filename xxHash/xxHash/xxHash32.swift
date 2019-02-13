//
//  xxHash32.swift
//  xxHash
//
//  Created by Daisuke T on 2019/02/12.
//  Copyright © 2019 xxHash. All rights reserved.
//

import Foundation

public class xxHash32 : xxHash {

	// MARK: - Enum, Const
	static let prime1: UInt32 = 2654435761	// 0b10011110001101110111100110110001
	static let prime2: UInt32 = 2246822519	// 0b10000101111010111100101001110111
	static let prime3: UInt32 = 3266489917	// 0b11000010101100101010111000111101
	static let prime4: UInt32 = 668265263	// 0b00100111110101001110101100101111
	static let prime5: UInt32 = 374761393	// 0b00010110010101100110011110110001


	struct State {
		var totalLen: UInt32 = 0
		var largeLen: Bool = false
		var v1: UInt32 = 0
		var v2: UInt32 = 0
		var v3: UInt32 = 0
		var v4: UInt32 = 0
		var mem = [UInt8](repeating: 0, count: 16)
		var memsize: Int = 0
		var reserved: UInt32 = 0	// never read nor write, might be removed in a future version
	}

	
	
	// MARK: - Member
	private var state = State()
	private var endian = xxHash.endian()

	public var seed = UInt32(0) {
		didSet {
			reset()
		}
	}



	// MARK: - Life cycle
	init(_ seed: UInt32, endian: Endian) {
		super.init()

		self.seed = seed
	}
	
	

	// MARK: - Utility
	static private func swap(_ x: UInt32) -> UInt32 {
		var res = UInt32(0)

		res |= (x << 24) & 0xff000000
		res |= (x << 8)  & 0x00ff0000
		res |= (x >> 8)  & 0x0000ff00
		res |= (x >> 24) & 0x000000ff

		return res
	}

	static private func swap(_ x: [UInt8]) -> [UInt8] {
		var res = [UInt8](repeating: 0, count: 4)
		
		res[0] = x[3]
		res[1] = x[2]
		res[2] = x[1]
		res[3] = x[0]

		return res
	}

	static private func round(_ seed: UInt32, input: UInt32) -> UInt32 {

		var seed2 = seed
		seed2 &+= input &* prime2
		seed2 = rotl(seed2, r: 13)
		seed2 &*= prime1

		return seed2
	}

	static private func avalanche(_ h: UInt32) -> UInt32 {

		var h2 = h
		h2 ^= h2 >> 15
		h2 &*= prime2
		h2 ^= h2 >> 13
		h2 &*= prime3
		h2 ^= h2 >> 16

		return h2
	}

	static private func UInt8ArrayToUInt32(_ array: [UInt8], index: Int) -> UInt32 {
		var block = UInt32(0)
		
		block |= UInt32(array[index << 2 + 0]) << 0
		block |= UInt32(array[index << 2 + 1]) << 8
		block |= UInt32(array[index << 2 + 2]) << 16
		block |= UInt32(array[index << 2 + 3]) << 24
		
		return block
	}
	
	static private func UInt8ArrayToUInt32(_ array: [UInt8], index: Int, endian: Endian) -> UInt32 {
		var block = UInt8ArrayToUInt32(array, index: index)

		if(endian == Endian.Little) {
			return block
		}
		
		
		// Big Endian
		block = swap(block)
		
		return block
	}

	
	static private func UInt32ToUInt8Array(_ block: UInt32) -> [UInt8] {
		var array = [UInt8](repeating: 0, count: 4)

		array[0] = UInt8((block & 0x000000ff) >> 0)
		array[1] = UInt8((block & 0x0000ff00) >> 8)
		array[2] = UInt8((block & 0x00ff0000) >> 16)
		array[3] = UInt8((block & 0xff000000) >> 24)

		return array
	}
	
	static private func UInt32ToUInt8Array(_ block: UInt32, endian: Endian) -> [UInt8] {
		var array = UInt32ToUInt8Array(block)
		
		if(endian == Endian.Little) {
			return array
		}
		
		
		// Big Endian
		array = swap(array)
		
		return array
	}
	
	
	
	// MARK: - Private
	static private func finalize(_ h: UInt32, array: [UInt8], len: Int, endian: Endian) -> UInt32 {

		var index = 0
		var h2 = h

		func process1() {
			h2 &+= UInt32(array[index]) &* prime5
			index += 1
			h2 = rotl(h2, r: 11) &* prime1
		}

		func process4() {
			h2 &+= UInt8ArrayToUInt32(array, index: index, endian: endian) &* prime3
			index += 1
			h2 = rotl(h2, r: 17) &* prime4
		}

		
		switch len & 15 {
		case 12:
			process4()
			fallthrough

		case 8:
			process4()
			fallthrough

		case 4:
			process4()
			return avalanche(h2)

			
		case 13:
			process4()
			fallthrough
			
		case 9:
			process4()
			fallthrough
			
		case 5:
			process4()
			process1()
			return avalanche(h2)
			
			
		case 14:
			process4()
			fallthrough
			
		case 10:
			process4()
			fallthrough
			
		case 6:
			process4()
			process1()
			process1()
			return avalanche(h2)

			
		case 15:
			process4()
			fallthrough
			
		case 11:
			process4()
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

		return h2	// reaching this point is deemed impossible
	}

	
	
	// MARK: - Oneshot
	static public func hash(_ array: [UInt8], seed: UInt32 = 0, endian: Endian = endian()) -> UInt32 {

		let len = array.count
		var h = UInt32(0)

		if len >= 16 {
			let limit = len - 15
			var v1 = seed &+ prime1 &+ prime2
			var v2 = seed &+ prime2
			var v3 = seed + 0
			var v4 = seed - prime1
			var index = 0

			repeat {

				v1 = round(v1, input: UInt8ArrayToUInt32(array, index: index))
				index += 4

				v2 = round(v2, input: UInt8ArrayToUInt32(array, index: index))
				index += 4

				v3 = round(v3, input: UInt8ArrayToUInt32(array, index: index))
				index += 4

				v4 = round(v4, input: UInt8ArrayToUInt32(array, index: index))
				index += 4

			} while(index < limit)
			
			h = rotl(v1, r: 1)  +
				rotl(v2, r: 7)  +
				rotl(v3, r: 12) +
				rotl(v4, r: 18)
		}
		else {
			h = seed + prime5
		}
		
		h += UInt32(len)

		h = finalize(h, array: array, len: len & 15, endian: endian)

		return h
	}

	
	
	// MARK: - Streaming
	public func reset() {
		state = State()

		state.v1 = seed &+ xxHash32.prime1 &+ xxHash32.prime2
		state.v2 = seed &+ xxHash32.prime2
		state.v3 = seed + 0
		state.v4 = seed - xxHash32.prime1
	}
	
	public func update(_ array: [UInt8]) {

		let len = array.count
		var index = 0

		state.totalLen += UInt32(len)
		state.largeLen = (len >= 16) || (state.totalLen >= 16)
		
		if state.memsize + len < 16 {

			// fill in tmp buffer
			for i in 0..<len {
				let index = state.memsize + i
				state.mem[index] = array[i]
			}
			
			state.memsize += len

			return
		}

		
		if state.memsize > 0 {
			// some data left from previous update
			for i in 0..<16 - state.memsize {
				let index = state.memsize + i
				state.mem[index] = array[i]
			}

			state.v1 = xxHash32.round(state.v1, input: xxHash32.UInt8ArrayToUInt32(state.mem, index: 0, endian: endian))
			state.v2 = xxHash32.round(state.v2, input: xxHash32.UInt8ArrayToUInt32(state.mem, index: 4, endian: endian))
			state.v3 = xxHash32.round(state.v3, input: xxHash32.UInt8ArrayToUInt32(state.mem, index: 8, endian: endian))
			state.v4 = xxHash32.round(state.v4, input: xxHash32.UInt8ArrayToUInt32(state.mem, index: 12, endian: endian))
			
			index += 16 - state.memsize
			state.memsize = 0
		}
		
		if index <= len - 16 {
			
			let limit = len - 16
			var v1 = state.v1
			var v2 = state.v2
			var v3 = state.v3
			var v4 = state.v4

			repeat {

				v1 = xxHash32.round(state.v1, input: xxHash32.UInt8ArrayToUInt32(array, index: index, endian: endian))
				index += 4

				v2 = xxHash32.round(state.v2, input: xxHash32.UInt8ArrayToUInt32(array, index: index, endian: endian))
				index += 4

				v3 = xxHash32.round(state.v3, input: xxHash32.UInt8ArrayToUInt32(array, index: index, endian: endian))
				index += 4

				v4 = xxHash32.round(state.v4, input: xxHash32.UInt8ArrayToUInt32(array, index: index, endian: endian))
				index += 4

			} while (index <= limit)
			
			state.v1 = v1
			state.v2 = v2
			state.v3 = v3
			state.v4 = v4
		
		}
		
		
		if index < len {
			for i in 0..<len - index {
				state.mem[i] = array[i]
			}

			state.memsize = len - index
		}

	}

	public func digest() -> UInt32 {
		var h = UInt32(0)

		if state.largeLen {
			h = xxHash.rotl(state.v1, r: 1) +
				xxHash.rotl(state.v2, r: 7) +
				xxHash.rotl(state.v3, r: 12) +
				xxHash.rotl(state.v4, r: 18)

		}
		else {
			h = state.v3 /* == seed */ + xxHash32.prime5
		}
		
		h += state.totalLen

		h = xxHash32.finalize(h, array: state.mem, len: state.memsize, endian: endian)
		
		return h
	}
	
	
	
	// MARK: - Canonical
	static public func canonicalFromHash(_ hash: UInt32, endian: Endian = endian()) -> [UInt8] {
		return UInt32ToUInt8Array(hash, endian: endian)
	}
	
	static public func hashFromCanonical(_ canonical: [UInt8], endian: Endian = endian()) -> UInt32 {
		return UInt8ArrayToUInt32(canonical, index: 0, endian: endian)
	}
	
}
