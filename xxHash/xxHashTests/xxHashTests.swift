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

    func test32OneShot() {
		XCTAssertEqual(xxHash32.hash("Hello World!"), 0x0bd69788)
		XCTAssertEqual(xxHash32.hash("Hello World!", seed: 0), 0x0bd69788)
		XCTAssertEqual(xxHash32.hash("Hello World!", seed: 1), 0x83e18820)
		XCTAssertEqual(xxHash32.hash("Hello World!", seed: 0x7fffffff), 0xe1d7fd5e)
    }

	func test64OneShot() {
		XCTAssertEqual(xxHash64.hash("Hello World!"), 0xa52b286a3e7f4d91)
		XCTAssertEqual(xxHash64.hash("Hello World!", seed: 0), 0xa52b286a3e7f4d91)
		XCTAssertEqual(xxHash64.hash("Hello World!", seed: 1), 0x44589be0a101d2ed)
		XCTAssertEqual(xxHash64.hash("Hello World!", seed: 0x7fffffff), 0xe64398b4046131bb)
	}

	func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
