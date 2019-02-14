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

    func testExample() {
		XCTAssertEqual(xxHash32.hash(Array("test".utf8)), 0x3e2023cf)
    }

    func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
