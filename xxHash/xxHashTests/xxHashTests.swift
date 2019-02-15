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

	
	
	func test32Overload() {
		XCTAssertEqual(xxHash32.hash("Hello World!"), xxHash32.hash(Array("Hello World!".utf8)))
		XCTAssertEqual(xxHash32.hash("Hello World!"), xxHash32.hash("Hello World!".data(using: .utf8)!))
	}

    func test32OneShot() {
		XCTAssertEqual(xxHash32.hash(""), 0x2cc5d05)
		XCTAssertEqual(xxHash32.hash("1"), 0xb6ecc8b2)
		XCTAssertEqual(xxHash32.hash("12"), 0xd43589af)
		XCTAssertEqual(xxHash32.hash("123"), 0xb6855437)
		XCTAssertEqual(xxHash32.hash("1234"), 0x1543429)
		XCTAssertEqual(xxHash32.hash("12345"), 0xb30d56b4)
		XCTAssertEqual(xxHash32.hash("123456"), 0xb7014066)
		XCTAssertEqual(xxHash32.hash("1234567"), 0xdd8d554e)
		XCTAssertEqual(xxHash32.hash("12345678"), 0x89f05aa5)
		XCTAssertEqual(xxHash32.hash("123456789"), 0x937bad67)
		XCTAssertEqual(xxHash32.hash("123456789A"), 0xee4c2232)
		XCTAssertEqual(xxHash32.hash("123456789AB"), 0x525ebf88)
		XCTAssertEqual(xxHash32.hash("123456789ABC"), 0x4c91c2e5)
		XCTAssertEqual(xxHash32.hash("123456789ABCD"), 0x772609a4)
		XCTAssertEqual(xxHash32.hash("123456789ABCDE"), 0xde40edc)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF"), 0x576e3cf9)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF1"), 0x82d80129)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF12"), 0x4689504)
	}

	func test32OneShotWithSeed() {
		XCTAssertEqual(xxHash32.hash("", seed:0), 0x2cc5d05)
		XCTAssertEqual(xxHash32.hash("", seed:1), 0xb2cb792)
		XCTAssertEqual(xxHash32.hash("", seed:0x7fffffff), 0xc89b854f)
		XCTAssertEqual(xxHash32.hash("1", seed:0), 0xb6ecc8b2)
		XCTAssertEqual(xxHash32.hash("1", seed:1), 0x642684c5)
		XCTAssertEqual(xxHash32.hash("1", seed:0x7fffffff), 0xe02326fc)
		XCTAssertEqual(xxHash32.hash("12", seed:0), 0xd43589af)
		XCTAssertEqual(xxHash32.hash("12", seed:1), 0xdf0e3329)
		XCTAssertEqual(xxHash32.hash("12", seed:0x7fffffff), 0x33a66723)
		XCTAssertEqual(xxHash32.hash("123", seed:0), 0xb6855437)
		XCTAssertEqual(xxHash32.hash("123", seed:1), 0x99280b78)
		XCTAssertEqual(xxHash32.hash("123", seed:0x7fffffff), 0xbbd3d824)
		XCTAssertEqual(xxHash32.hash("1234", seed:0), 0x1543429)
		XCTAssertEqual(xxHash32.hash("1234", seed:1), 0xe17e2fa9)
		XCTAssertEqual(xxHash32.hash("1234", seed:0x7fffffff), 0xf120e3f8)
		XCTAssertEqual(xxHash32.hash("12345", seed:0), 0xb30d56b4)
		XCTAssertEqual(xxHash32.hash("12345", seed:1), 0x97a348b6)
		XCTAssertEqual(xxHash32.hash("12345", seed:0x7fffffff), 0x423abdc2)
		XCTAssertEqual(xxHash32.hash("123456", seed:0), 0xb7014066)
		XCTAssertEqual(xxHash32.hash("123456", seed:1), 0x1477c29)
		XCTAssertEqual(xxHash32.hash("123456", seed:0x7fffffff), 0x9aab3db)
		XCTAssertEqual(xxHash32.hash("1234567", seed:0), 0xdd8d554e)
		XCTAssertEqual(xxHash32.hash("1234567", seed:1), 0x993f0ea5)
		XCTAssertEqual(xxHash32.hash("1234567", seed:0x7fffffff), 0x8217d312)
		XCTAssertEqual(xxHash32.hash("12345678", seed:0), 0x89f05aa5)
		XCTAssertEqual(xxHash32.hash("12345678", seed:1), 0xcfd577ae)
		XCTAssertEqual(xxHash32.hash("12345678", seed:0x7fffffff), 0xde5e8e72)
		XCTAssertEqual(xxHash32.hash("123456789", seed:0), 0x937bad67)
		XCTAssertEqual(xxHash32.hash("123456789", seed:1), 0xf261918c)
		XCTAssertEqual(xxHash32.hash("123456789", seed:0x7fffffff), 0xdbe6ea46)
		XCTAssertEqual(xxHash32.hash("123456789A", seed:0), 0xee4c2232)
		XCTAssertEqual(xxHash32.hash("123456789A", seed:1), 0x277c5d99)
		XCTAssertEqual(xxHash32.hash("123456789A", seed:0x7fffffff), 0xa5ae4159)
		XCTAssertEqual(xxHash32.hash("123456789AB", seed:0), 0x525ebf88)
		XCTAssertEqual(xxHash32.hash("123456789AB", seed:1), 0x442dd1f7)
		XCTAssertEqual(xxHash32.hash("123456789AB", seed:0x7fffffff), 0xf51bd72c)
		XCTAssertEqual(xxHash32.hash("123456789ABC", seed:0), 0x4c91c2e5)
		XCTAssertEqual(xxHash32.hash("123456789ABC", seed:1), 0xceb445bc)
		XCTAssertEqual(xxHash32.hash("123456789ABC", seed:0x7fffffff), 0xe2e10cad)
		XCTAssertEqual(xxHash32.hash("123456789ABCD", seed:0), 0x772609a4)
		XCTAssertEqual(xxHash32.hash("123456789ABCD", seed:1), 0x77dfbea9)
		XCTAssertEqual(xxHash32.hash("123456789ABCD", seed:0x7fffffff), 0xe1172c32)
		XCTAssertEqual(xxHash32.hash("123456789ABCDE", seed:0), 0xde40edc)
		XCTAssertEqual(xxHash32.hash("123456789ABCDE", seed:1), 0xc07612ac)
		XCTAssertEqual(xxHash32.hash("123456789ABCDE", seed:0x7fffffff), 0x46bd1017)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF", seed:0), 0x576e3cf9)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF", seed:1), 0x4058625d)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF", seed:0x7fffffff), 0xa7f06f9d)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF1", seed:0), 0x82d80129)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF1", seed:1), 0x70ab0be4)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF1", seed:0x7fffffff), 0xc355753c)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF12", seed:0), 0x4689504)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF12", seed:1), 0xa0ef0a1d)
		XCTAssertEqual(xxHash32.hash("123456789ABCDEF12", seed:0x7fffffff), 0x8676bee4)
	}

	func test32Update() {
		do {
			let xxh = xxHash32()
			
			XCTAssertEqual(xxHash32.hash(""), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.hash("1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.hash("12"), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash32.hash("123"), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash32.hash("1234"), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash32.hash("12345"), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash32.hash("123456"), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash32.hash("1234567"), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash32.hash("12345678"), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash32.hash("123456789"), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash32.hash("123456789A"), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash32.hash("123456789AB"), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash32.hash("123456789ABC"), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash32.hash("123456789ABCD"), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash32.hash("123456789ABCDE"), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF"), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF1"), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12"), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash32()
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12"), xxh.digest())
		}
		
		do {
			let xxh = xxHash32()
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF123456789ABCDEF12"), xxh.digest())
		}
	}

	func test32UpdateWithSeed() {
		do {
			let xxh = xxHash32(0x7fffffff)
			
			XCTAssertEqual(xxHash32.hash("", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.hash("1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.hash("12", seed: 0x7fffffff), xxh.digest())
			xxh.update("3")
			XCTAssertEqual(xxHash32.hash("123", seed: 0x7fffffff), xxh.digest())
			xxh.update("4")
			XCTAssertEqual(xxHash32.hash("1234", seed: 0x7fffffff), xxh.digest())
			xxh.update("5")
			XCTAssertEqual(xxHash32.hash("12345", seed: 0x7fffffff), xxh.digest())
			xxh.update("6")
			XCTAssertEqual(xxHash32.hash("123456", seed: 0x7fffffff), xxh.digest())
			xxh.update("7")
			XCTAssertEqual(xxHash32.hash("1234567", seed: 0x7fffffff), xxh.digest())
			xxh.update("8")
			XCTAssertEqual(xxHash32.hash("12345678", seed: 0x7fffffff), xxh.digest())
			xxh.update("9")
			XCTAssertEqual(xxHash32.hash("123456789", seed: 0x7fffffff), xxh.digest())
			xxh.update("A")
			XCTAssertEqual(xxHash32.hash("123456789A", seed: 0x7fffffff), xxh.digest())
			xxh.update("B")
			XCTAssertEqual(xxHash32.hash("123456789AB", seed: 0x7fffffff), xxh.digest())
			xxh.update("C")
			XCTAssertEqual(xxHash32.hash("123456789ABC", seed: 0x7fffffff), xxh.digest())
			xxh.update("D")
			XCTAssertEqual(xxHash32.hash("123456789ABCD", seed: 0x7fffffff), xxh.digest())
			xxh.update("E")
			XCTAssertEqual(xxHash32.hash("123456789ABCDE", seed: 0x7fffffff), xxh.digest())
			xxh.update("F")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF", seed: 0x7fffffff), xxh.digest())
			xxh.update("1")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF1", seed: 0x7fffffff), xxh.digest())
			xxh.update("2")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash32(0x7fffffff)
			xxh.update("123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
		
		do {
			let xxh = xxHash32(0x7fffffff)
			xxh.update("123456789ABCDEF123456789ABCDEF12")
			XCTAssertEqual(xxHash32.hash("123456789ABCDEF123456789ABCDEF12", seed: 0x7fffffff), xxh.digest())
		}
	}

	func test32Reset() {
		let xxh = xxHash32()

		xxh.update("123456789ABCDEF")
		xxh.reset()
		XCTAssertEqual(xxh.digest(), xxHash32().digest())
		
		xxh.update("123456789ABCDEF")
		xxh.seed = 0x7fffffff	// Reset when setting seed.
		XCTAssertEqual(xxh.digest(), xxHash32(0x7fffffff).digest())
	}

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

	/*
	func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	*/

}
