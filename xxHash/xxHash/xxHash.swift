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

	
	// MARK: - Utility
	static func rotl<T: FixedWidthInteger>(_ x: T, r: Int) -> T {
		return (x << r) | (x >> (T.bitWidth - r))
	}

	static func endian() -> Endian {
		if CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) {
			return Endian.Little
		}

		return Endian.Big
	}
}
