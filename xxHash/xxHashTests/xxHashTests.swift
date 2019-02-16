//
//  xxHashTests.swift
//  xxHashTests
//
//  Created by Daisuke T on 2019/02/12.
//  Copyright © 2019 xxHash. All rights reserved.
//

import XCTest
@testable import xxHash

class xxHashTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	
	
	// MARK: - Overload
	func test32Overload() {
		XCTAssertEqual(xxHash32.digest("Hello World!"), xxHash32.digest(Array("Hello World!".utf8)))
		XCTAssertEqual(xxHash32.digest("Hello World!"), xxHash32.digest("Hello World!".data(using: .utf8)!))
	}

	func test64Overload() {
		XCTAssertEqual(xxHash64.digest("Hello World!"), xxHash64.digest(Array("Hello World!".utf8)))
		XCTAssertEqual(xxHash64.digest("Hello World!"), xxHash64.digest("Hello World!".data(using: .utf8)!))
	}

	
	
	// MARK: - One-shot
	func test32OneShot() {
		XCTAssertEqual(xxHash32.digest(""), 0x2cc5d05)
		XCTAssertEqual(xxHash32.digest("1"), 0xb6ecc8b2)
		XCTAssertEqual(xxHash32.digest("12"), 0xd43589af)
		XCTAssertEqual(xxHash32.digest("123"), 0xb6855437)
		XCTAssertEqual(xxHash32.digest("1234"), 0x1543429)
		XCTAssertEqual(xxHash32.digest("12345"), 0xb30d56b4)
		XCTAssertEqual(xxHash32.digest("123456"), 0xb7014066)
		XCTAssertEqual(xxHash32.digest("1234567"), 0xdd8d554e)
		XCTAssertEqual(xxHash32.digest("12345678"), 0x89f05aa5)
		XCTAssertEqual(xxHash32.digest("123456789"), 0x937bad67)
		XCTAssertEqual(xxHash32.digest("123456789A"), 0xee4c2232)
		XCTAssertEqual(xxHash32.digest("123456789AB"), 0x525ebf88)
		XCTAssertEqual(xxHash32.digest("123456789ABC"), 0x4c91c2e5)
		XCTAssertEqual(xxHash32.digest("123456789ABCD"), 0x772609a4)
		XCTAssertEqual(xxHash32.digest("123456789ABCDE"), 0xde40edc)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF"), 0x576e3cf9)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF1"), 0x82d80129)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF12"), 0x4689504)
	}
	
	func test32OneShotWithSeed() {
		XCTAssertEqual(xxHash32.digest("", seed:0), 0x2cc5d05)
		XCTAssertEqual(xxHash32.digest("", seed:1), 0xb2cb792)
		XCTAssertEqual(xxHash32.digest("", seed:0x7fffffff), 0xc89b854f)
		XCTAssertEqual(xxHash32.digest("1", seed:0), 0xb6ecc8b2)
		XCTAssertEqual(xxHash32.digest("1", seed:1), 0x642684c5)
		XCTAssertEqual(xxHash32.digest("1", seed:0x7fffffff), 0xe02326fc)
		XCTAssertEqual(xxHash32.digest("12", seed:0), 0xd43589af)
		XCTAssertEqual(xxHash32.digest("12", seed:1), 0xdf0e3329)
		XCTAssertEqual(xxHash32.digest("12", seed:0x7fffffff), 0x33a66723)
		XCTAssertEqual(xxHash32.digest("123", seed:0), 0xb6855437)
		XCTAssertEqual(xxHash32.digest("123", seed:1), 0x99280b78)
		XCTAssertEqual(xxHash32.digest("123", seed:0x7fffffff), 0xbbd3d824)
		XCTAssertEqual(xxHash32.digest("1234", seed:0), 0x1543429)
		XCTAssertEqual(xxHash32.digest("1234", seed:1), 0xe17e2fa9)
		XCTAssertEqual(xxHash32.digest("1234", seed:0x7fffffff), 0xf120e3f8)
		XCTAssertEqual(xxHash32.digest("12345", seed:0), 0xb30d56b4)
		XCTAssertEqual(xxHash32.digest("12345", seed:1), 0x97a348b6)
		XCTAssertEqual(xxHash32.digest("12345", seed:0x7fffffff), 0x423abdc2)
		XCTAssertEqual(xxHash32.digest("123456", seed:0), 0xb7014066)
		XCTAssertEqual(xxHash32.digest("123456", seed:1), 0x1477c29)
		XCTAssertEqual(xxHash32.digest("123456", seed:0x7fffffff), 0x9aab3db)
		XCTAssertEqual(xxHash32.digest("1234567", seed:0), 0xdd8d554e)
		XCTAssertEqual(xxHash32.digest("1234567", seed:1), 0x993f0ea5)
		XCTAssertEqual(xxHash32.digest("1234567", seed:0x7fffffff), 0x8217d312)
		XCTAssertEqual(xxHash32.digest("12345678", seed:0), 0x89f05aa5)
		XCTAssertEqual(xxHash32.digest("12345678", seed:1), 0xcfd577ae)
		XCTAssertEqual(xxHash32.digest("12345678", seed:0x7fffffff), 0xde5e8e72)
		XCTAssertEqual(xxHash32.digest("123456789", seed:0), 0x937bad67)
		XCTAssertEqual(xxHash32.digest("123456789", seed:1), 0xf261918c)
		XCTAssertEqual(xxHash32.digest("123456789", seed:0x7fffffff), 0xdbe6ea46)
		XCTAssertEqual(xxHash32.digest("123456789A", seed:0), 0xee4c2232)
		XCTAssertEqual(xxHash32.digest("123456789A", seed:1), 0x277c5d99)
		XCTAssertEqual(xxHash32.digest("123456789A", seed:0x7fffffff), 0xa5ae4159)
		XCTAssertEqual(xxHash32.digest("123456789AB", seed:0), 0x525ebf88)
		XCTAssertEqual(xxHash32.digest("123456789AB", seed:1), 0x442dd1f7)
		XCTAssertEqual(xxHash32.digest("123456789AB", seed:0x7fffffff), 0xf51bd72c)
		XCTAssertEqual(xxHash32.digest("123456789ABC", seed:0), 0x4c91c2e5)
		XCTAssertEqual(xxHash32.digest("123456789ABC", seed:1), 0xceb445bc)
		XCTAssertEqual(xxHash32.digest("123456789ABC", seed:0x7fffffff), 0xe2e10cad)
		XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:0), 0x772609a4)
		XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:1), 0x77dfbea9)
		XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:0x7fffffff), 0xe1172c32)
		XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:0), 0xde40edc)
		XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:1), 0xc07612ac)
		XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:0x7fffffff), 0x46bd1017)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:0), 0x576e3cf9)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:1), 0x4058625d)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:0x7fffffff), 0xa7f06f9d)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:0), 0x82d80129)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:1), 0x70ab0be4)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:0x7fffffff), 0xc355753c)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:0), 0x4689504)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:1), 0xa0ef0a1d)
		XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:0x7fffffff), 0x8676bee4)
	}
	
	func test64OneShot() {
		XCTAssertEqual(xxHash64.digest(""), 0xef46db3751d8e999)
		XCTAssertEqual(xxHash64.digest("1"), 0xb7b41276360564d4)
		XCTAssertEqual(xxHash64.digest("12"), 0x5460f49adbe7aba2)
		XCTAssertEqual(xxHash64.digest("123"), 0x3c697d223fa7e885)
		XCTAssertEqual(xxHash64.digest("1234"), 0xd8316e61d84f6ba4)
		XCTAssertEqual(xxHash64.digest("12345"), 0xc6f2d2dd0ad64fb6)
		XCTAssertEqual(xxHash64.digest("123456"), 0x2b2dc38aaa53c322)
		XCTAssertEqual(xxHash64.digest("1234567"), 0xd3a46e9108289359)
		XCTAssertEqual(xxHash64.digest("12345678"), 0xd2d02f08cf7cfd4a)
		XCTAssertEqual(xxHash64.digest("123456789"), 0x8cb841db40e6ae83)
		XCTAssertEqual(xxHash64.digest("123456789A"), 0xd86259788ea6d316)
		XCTAssertEqual(xxHash64.digest("123456789AB"), 0x1d1615d71699db6b)
		XCTAssertEqual(xxHash64.digest("123456789ABC"), 0x226a8b511223db6c)
		XCTAssertEqual(xxHash64.digest("123456789ABCD"), 0x7e32a5bf7d4d75)
		XCTAssertEqual(xxHash64.digest("123456789ABCDE"), 0x1167004bac2411de)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF"), 0xa66df83f00e9202d)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF1"), 0x2ff14a9841f54cc3)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF12"), 0x880a293145b975a0)
	}

	func test64OneShotWithSeed() {
		XCTAssertEqual(xxHash64.digest("", seed:0), 0xef46db3751d8e999)
		XCTAssertEqual(xxHash64.digest("", seed:1), 0xd5afba1336a3be4b)
		XCTAssertEqual(xxHash64.digest("", seed:0x7fffffff), 0x2655611cbf9cdb34)
		XCTAssertEqual(xxHash64.digest("1", seed:0), 0xb7b41276360564d4)
		XCTAssertEqual(xxHash64.digest("1", seed:1), 0x192aba5fd13fb67d)
		XCTAssertEqual(xxHash64.digest("1", seed:0x7fffffff), 0xc633803a4aecc9)
		XCTAssertEqual(xxHash64.digest("12", seed:0), 0x5460f49adbe7aba2)
		XCTAssertEqual(xxHash64.digest("12", seed:1), 0x75b53fdb7dce12fa)
		XCTAssertEqual(xxHash64.digest("12", seed:0x7fffffff), 0xb16cec1417b322a0)
		XCTAssertEqual(xxHash64.digest("123", seed:0), 0x3c697d223fa7e885)
		XCTAssertEqual(xxHash64.digest("123", seed:1), 0x4b805d862c3b7497)
		XCTAssertEqual(xxHash64.digest("123", seed:0x7fffffff), 0x19a2f46434bc317a)
		XCTAssertEqual(xxHash64.digest("1234", seed:0), 0xd8316e61d84f6ba4)
		XCTAssertEqual(xxHash64.digest("1234", seed:1), 0xe9feb3476d8788cb)
		XCTAssertEqual(xxHash64.digest("1234", seed:0x7fffffff), 0xf46ec96a022e8572)
		XCTAssertEqual(xxHash64.digest("12345", seed:0), 0xc6f2d2dd0ad64fb6)
		XCTAssertEqual(xxHash64.digest("12345", seed:1), 0x8b4dc636e784c7e5)
		XCTAssertEqual(xxHash64.digest("12345", seed:0x7fffffff), 0xef98a836c0097965)
		XCTAssertEqual(xxHash64.digest("123456", seed:0), 0x2b2dc38aaa53c322)
		XCTAssertEqual(xxHash64.digest("123456", seed:1), 0xbaf38605878c2322)
		XCTAssertEqual(xxHash64.digest("123456", seed:0x7fffffff), 0x4ae897dc1885851d)
		XCTAssertEqual(xxHash64.digest("1234567", seed:0), 0xd3a46e9108289359)
		XCTAssertEqual(xxHash64.digest("1234567", seed:1), 0x3a9b3211fb1bcbd2)
		XCTAssertEqual(xxHash64.digest("1234567", seed:0x7fffffff), 0x743513f8fd9ef9d6)
		XCTAssertEqual(xxHash64.digest("12345678", seed:0), 0xd2d02f08cf7cfd4a)
		XCTAssertEqual(xxHash64.digest("12345678", seed:1), 0x339c66ff536000b7)
		XCTAssertEqual(xxHash64.digest("12345678", seed:0x7fffffff), 0xe19d2db01f7df4ff)
		XCTAssertEqual(xxHash64.digest("123456789", seed:0), 0x8cb841db40e6ae83)
		XCTAssertEqual(xxHash64.digest("123456789", seed:1), 0x1a4cc2c9e8079790)
		XCTAssertEqual(xxHash64.digest("123456789", seed:0x7fffffff), 0x5d3bba73949569e)
		XCTAssertEqual(xxHash64.digest("123456789A", seed:0), 0xd86259788ea6d316)
		XCTAssertEqual(xxHash64.digest("123456789A", seed:1), 0x67549dd3d13a19a6)
		XCTAssertEqual(xxHash64.digest("123456789A", seed:0x7fffffff), 0xd29f40df8a0945ad)
		XCTAssertEqual(xxHash64.digest("123456789AB", seed:0), 0x1d1615d71699db6b)
		XCTAssertEqual(xxHash64.digest("123456789AB", seed:1), 0x9dce50837f267a20)
		XCTAssertEqual(xxHash64.digest("123456789AB", seed:0x7fffffff), 0xcdd1136284934a05)
		XCTAssertEqual(xxHash64.digest("123456789ABC", seed:0), 0x226a8b511223db6c)
		XCTAssertEqual(xxHash64.digest("123456789ABC", seed:1), 0x3fe87cbe38e1a2ad)
		XCTAssertEqual(xxHash64.digest("123456789ABC", seed:0x7fffffff), 0xae28ae51e1e3be34)
		XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:0), 0x7e32a5bf7d4d75)
		XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:1), 0x80473dfc05bbd680)
		XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:0x7fffffff), 0xf7a2dfc5fc75df85)
		XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:0), 0x1167004bac2411de)
		XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:1), 0x864bb1086f4c841b)
		XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:0x7fffffff), 0xe26a852901bc6a8e)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:0), 0xa66df83f00e9202d)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:1), 0x907979bf155f0506)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:0x7fffffff), 0xe8d84202a16e482f)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:0), 0x2ff14a9841f54cc3)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:1), 0x78440c0674f9217c)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:0x7fffffff), 0x512e1dc62a511c58)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:0), 0x880a293145b975a0)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:1), 0x844b03a36096e2bd)
		XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:0x7fffffff), 0xbd8f1f044ed860af)
	}



	// MARK: - Update
	func test32Update() {
		do {
			let xxh = xxHash32()
			
			XCTAssertEqual(xxHash32.digest(""), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.digest("1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.digest("12"), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash32.digest("123"), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash32.digest("1234"), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash32.digest("12345"), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash32.digest("123456"), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash32.digest("1234567"), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash32.digest("12345678"), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash32.digest("123456789"), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash32.digest("123456789A"), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash32.digest("123456789AB"), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash32.digest("123456789ABC"), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash32.digest("123456789ABCD"), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash32.digest("123456789ABCDE"), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF"), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12"), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash32()
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash32()
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12"), xxh.digest())
		}
	}

	func test32UpdateWithSeed() {
		do {
			let xxh = xxHash32(0x7fffffff)
			
			XCTAssertEqual(xxHash32.digest("", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.digest("1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.digest("12", seed: 0x7fffffff), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash32.digest("123", seed: 0x7fffffff), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash32.digest("1234", seed: 0x7fffffff), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash32.digest("12345", seed: 0x7fffffff), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash32.digest("123456", seed: 0x7fffffff), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash32.digest("1234567", seed: 0x7fffffff), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash32.digest("12345678", seed: 0x7fffffff), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash32.digest("123456789", seed: 0x7fffffff), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash32.digest("123456789A", seed: 0x7fffffff), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash32.digest("123456789AB", seed: 0x7fffffff), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash32.digest("123456789ABC", seed: 0x7fffffff), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash32.digest("123456789ABCD", seed: 0x7fffffff), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed: 0x7fffffff), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash32(0x7fffffff)
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash32(0x7fffffff)
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
	}

	func test64Update() {
		do {
			let xxh = xxHash64()
			
			XCTAssertEqual(xxHash64.digest(""), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash64.digest("1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash64.digest("12"), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash64.digest("123"), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash64.digest("1234"), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash64.digest("12345"), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash64.digest("123456"), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash64.digest("1234567"), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash64.digest("12345678"), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash64.digest("123456789"), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash64.digest("123456789A"), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash64.digest("123456789AB"), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash64.digest("123456789ABC"), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash64.digest("123456789ABCD"), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash64.digest("123456789ABCDE"), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF"), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12"), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash64()
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash64()
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12"), xxh.digest())
		}
	}
	
	func test64UpdateWithSeed() {
		do {
			let xxh = xxHash64(0x7fffffff)
			
			XCTAssertEqual(xxHash64.digest("", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash64.digest("1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash64.digest("12", seed: 0x7fffffff), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash64.digest("123", seed: 0x7fffffff), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash64.digest("1234", seed: 0x7fffffff), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash64.digest("12345", seed: 0x7fffffff), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash64.digest("123456", seed: 0x7fffffff), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash64.digest("1234567", seed: 0x7fffffff), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash64.digest("12345678", seed: 0x7fffffff), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash64.digest("123456789", seed: 0x7fffffff), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash64.digest("123456789A", seed: 0x7fffffff), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash64.digest("123456789AB", seed: 0x7fffffff), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash64.digest("123456789ABC", seed: 0x7fffffff), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash64.digest("123456789ABCD", seed: 0x7fffffff), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed: 0x7fffffff), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash64(0x7fffffff)
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash64(0x7fffffff)
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
	}
	
	
	
	// MARK: - Reset
	func test32Reset() {
		let xxh = xxHash32()

		xxh.update("123456789ABCDEF")
		xxh.reset()
		XCTAssertEqual(xxh.digest(), xxHash32().digest())
		
		xxh.update("123456789ABCDEF")
		xxh.seed = 0x7fffffff	// Reset when setting seed.
		XCTAssertEqual(xxh.digest(), xxHash32(0x7fffffff).digest())
	}

	func test64Reset() {
		let xxh = xxHash64()
		
		xxh.update("123456789ABCDEF")
		xxh.reset()
		XCTAssertEqual(xxh.digest(), xxHash64().digest())
		
		xxh.update("123456789ABCDEF")
		xxh.seed = 0x7fffffff	// Reset when setting seed.
		XCTAssertEqual(xxh.digest(), xxHash64(0x7fffffff).digest())
	}



	// MARK: - Copy
	func test32Copy() {
		do {
			let xxh = xxHash32()
			let xxh2 = xxh
			
			xxh.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
			
			xxh2.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
		}

		do {
			let xxh = xxHash32(0x7fffffff)
			let xxh2 = xxh
			
			xxh.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
			
			xxh2.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
		}
	}

	func test64Copy() {
		do {
			let xxh = xxHash64()
			let xxh2 = xxh
			
			xxh.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
			
			xxh2.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
		}
		
		do {
			let xxh = xxHash64(0x7fffffff)
			let xxh2 = xxh
			
			xxh.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
			
			xxh2.update("123456789ABCDEF")
			XCTAssertEqual(xxh.digest(), xxh2.digest())
		}
	}



	func test32File() {
		do {
			let xxh = xxHash32()

			let bundle = Bundle(for: type(of: self))
			let path = bundle.path(forResource: "alice29", ofType: "txt")!
			let data = NSData(contentsOfFile: path)
			let array = [UInt8](data! as Data)

			let bufSize = 1024
			var index = 0
			var flag = true
			
			
			repeat {
				var buf = [UInt8]()
				for _ in 0..<bufSize {
					buf.append(array[index])
					index += 1
					if index >= array.count {
						flag = false
						break
					}
					
				}
				
				xxh.update(buf)
				
			} while(flag)
			
			XCTAssertEqual(xxh.digest(), 0xafc8e0c2)
		}
	}

	func test32FileWithSeed() {
		do {
			let xxh = xxHash32(0x7fffffff)
			
			let bundle = Bundle(for: type(of: self))
			let path = bundle.path(forResource: "alice29", ofType: "txt")!
			let data = NSData(contentsOfFile: path)
			let array = [UInt8](data! as Data)
			
			let bufSize = 1024
			var index = 0
			var flag = true
			
			
			repeat {
				var buf = [UInt8]()
				for _ in 0..<bufSize {
					buf.append(array[index])
					index += 1
					if index >= array.count {
						flag = false
						break
					}
					
				}
				
				xxh.update(buf)
				
			} while(flag)
			
			XCTAssertEqual(xxh.digest(), 0x7d7e2195)
		}
	}
	
	func test32Canonical() {
		var hash = UInt32(0x12345678)
		var canonical = [UInt8]()

		canonical = xxHash32.canonicalFromHash(hash)
		XCTAssertEqual(canonical[0], 0x12)
		XCTAssertEqual(canonical[1], 0x34)
		XCTAssertEqual(canonical[2], 0x56)
		XCTAssertEqual(canonical[3], 0x78)

		hash = xxHash32.hashFromCanonical(canonical)
		XCTAssertEqual(hash, 0x12345678)
	}
	
	/*
	func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	*/

}
