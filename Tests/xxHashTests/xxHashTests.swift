//
//  xxHashTests.swift
//  xxHash-Swift
//
//  Created by Daisuke T on 2019/02/12.
//  Copyright © 2019 xxHash-Swift. All rights reserved.
//

import XCTest
#if SWIFT_PACKAGE
@testable import xxHash_Swift
#else
@testable import xxHash
#endif

class xxHashTests: XCTestCase {
  
  // MARK: - Property
  static var allTests = [
    ("test32Overload", test32Overload),
    ("test64Overload", test64Overload),
    ("test3_64Overload", test3_64Overload),
    ("test3_128Overload", test3_128Overload),
    ("test32OneShot", test32OneShot),
    ("test32OneShotWithSeed", test32OneShotWithSeed),
    ("test64OneShot", test64OneShot),
    ("test64OneShotWithSeed", test64OneShotWithSeed),
    ("test3_64OneShot", test3_64OneShot),
    ("test3_64OneShotWithSeed", test3_64OneShotWithSeed),
    ("test3_128OneShot", test3_128OneShot),
    ("test3_128OneShotWithSeed", test3_128OneShotWithSeed),
    ("test32Update", test32Update),
    ("test32UpdateWithSeed", test32UpdateWithSeed),
    ("test64Update", test64Update),
    ("test64UpdateWithSeed", test64UpdateWithSeed),
    ("test32Reset", test32Reset),
    ("test64Reset", test64Reset),
    ("test32Copy", test32Copy),
    ("test64Copy", test64Copy),
    ("test32File", test32File),
    ("test32FileWithSeed", test32FileWithSeed),
    ("test64File", test64File),
    ("test64FileWithSeed", test64FileWithSeed),
    ("test32Canonical", test32Canonical),
    ("test64Canonical", test64Canonical),
  ]
  
  
  
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
  
  func test3_64Overload() {
    XCTAssertEqual(xxHash3.digest64("Hello World!"), xxHash3.digest64(Array("Hello World!".utf8)))
    XCTAssertEqual(xxHash3.digest64("Hello World!"), xxHash3.digest64("Hello World!".data(using: .utf8)!))
  }
  
  func test3_128Overload() {
    XCTAssertEqual(xxHash3.digest128("Hello World!"), xxHash3.digest128(Array("Hello World!".utf8)))
    XCTAssertEqual(xxHash3.digest128("Hello World!"), xxHash3.digest128("Hello World!".data(using: .utf8)!))
  }
  
  
  // MARK: - One-shot
  func test32OneShot() {
    XCTAssertEqual(xxHash32.digestHex("").lowercased(), "02cc5d05")
    
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
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123"), 0xb6786140)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234"), 0xc33e9edc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345"), 0x8cc12eb4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456"), 0xf28177f6)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567"), 0xcf887691)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678"), 0x7b1af730)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789"), 0x1f34766d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A"), 0x772d203c)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB"), 0x30967301)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC"), 0x2b595fa)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD"), 0xd09d9fe)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE"), 0xdacc797)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF"), 0x2f375968)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1"), 0xff6d43a9)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12"), 0x852d687c)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123"), 0xef78a638)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234"), 0xb8939d98)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345"), 0x83a9e3bc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456"), 0xb3b65d47)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567"), 0x929b9cc4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678"), 0xe438dfb8)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789"), 0xed8d024f)
  }
  
  func test32OneShotWithSeed() {
    let seed = UInt32(0x7fffffff)
    
    XCTAssertEqual(xxHash32.digest("", seed:0), 0x2cc5d05)
    XCTAssertEqual(xxHash32.digest("", seed:1), 0xb2cb792)
    XCTAssertEqual(xxHash32.digest("", seed:seed), 0xc89b854f)
    XCTAssertEqual(xxHash32.digest("1", seed:0), 0xb6ecc8b2)
    XCTAssertEqual(xxHash32.digest("1", seed:1), 0x642684c5)
    XCTAssertEqual(xxHash32.digest("1", seed:seed), 0xe02326fc)
    XCTAssertEqual(xxHash32.digest("12", seed:0), 0xd43589af)
    XCTAssertEqual(xxHash32.digest("12", seed:1), 0xdf0e3329)
    XCTAssertEqual(xxHash32.digest("12", seed:seed), 0x33a66723)
    XCTAssertEqual(xxHash32.digest("123", seed:0), 0xb6855437)
    XCTAssertEqual(xxHash32.digest("123", seed:1), 0x99280b78)
    XCTAssertEqual(xxHash32.digest("123", seed:seed), 0xbbd3d824)
    XCTAssertEqual(xxHash32.digest("1234", seed:0), 0x1543429)
    XCTAssertEqual(xxHash32.digest("1234", seed:1), 0xe17e2fa9)
    XCTAssertEqual(xxHash32.digest("1234", seed:seed), 0xf120e3f8)
    XCTAssertEqual(xxHash32.digest("12345", seed:0), 0xb30d56b4)
    XCTAssertEqual(xxHash32.digest("12345", seed:1), 0x97a348b6)
    XCTAssertEqual(xxHash32.digest("12345", seed:seed), 0x423abdc2)
    XCTAssertEqual(xxHash32.digest("123456", seed:0), 0xb7014066)
    XCTAssertEqual(xxHash32.digest("123456", seed:1), 0x1477c29)
    XCTAssertEqual(xxHash32.digest("123456", seed:seed), 0x9aab3db)
    XCTAssertEqual(xxHash32.digest("1234567", seed:0), 0xdd8d554e)
    XCTAssertEqual(xxHash32.digest("1234567", seed:1), 0x993f0ea5)
    XCTAssertEqual(xxHash32.digest("1234567", seed:seed), 0x8217d312)
    XCTAssertEqual(xxHash32.digest("12345678", seed:0), 0x89f05aa5)
    XCTAssertEqual(xxHash32.digest("12345678", seed:1), 0xcfd577ae)
    XCTAssertEqual(xxHash32.digest("12345678", seed:seed), 0xde5e8e72)
    XCTAssertEqual(xxHash32.digest("123456789", seed:0), 0x937bad67)
    XCTAssertEqual(xxHash32.digest("123456789", seed:1), 0xf261918c)
    XCTAssertEqual(xxHash32.digest("123456789", seed:seed), 0xdbe6ea46)
    XCTAssertEqual(xxHash32.digest("123456789A", seed:0), 0xee4c2232)
    XCTAssertEqual(xxHash32.digest("123456789A", seed:1), 0x277c5d99)
    XCTAssertEqual(xxHash32.digest("123456789A", seed:seed), 0xa5ae4159)
    XCTAssertEqual(xxHash32.digest("123456789AB", seed:0), 0x525ebf88)
    XCTAssertEqual(xxHash32.digest("123456789AB", seed:1), 0x442dd1f7)
    XCTAssertEqual(xxHash32.digest("123456789AB", seed:seed), 0xf51bd72c)
    XCTAssertEqual(xxHash32.digest("123456789ABC", seed:0), 0x4c91c2e5)
    XCTAssertEqual(xxHash32.digest("123456789ABC", seed:1), 0xceb445bc)
    XCTAssertEqual(xxHash32.digest("123456789ABC", seed:seed), 0xe2e10cad)
    XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:0), 0x772609a4)
    XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:1), 0x77dfbea9)
    XCTAssertEqual(xxHash32.digest("123456789ABCD", seed:seed), 0xe1172c32)
    XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:0), 0xde40edc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:1), 0xc07612ac)
    XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed:seed), 0x46bd1017)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:0), 0x576e3cf9)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:1), 0x4058625d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed:seed), 0xa7f06f9d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:0), 0x82d80129)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:1), 0x70ab0be4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed:seed), 0xc355753c)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:0), 0x4689504)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:1), 0xa0ef0a1d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed:seed), 0x8676bee4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123", seed:0), 0xb6786140)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123", seed:1), 0x690db3c1)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123", seed:seed), 0xb6abf25e)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234", seed:0), 0xc33e9edc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234", seed:1), 0x2e4be1fb)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234", seed:seed), 0x64118292)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345", seed:0), 0x8cc12eb4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345", seed:1), 0x91d7af7f)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345", seed:seed), 0xbbb5c9a3)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456", seed:0), 0xf28177f6)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456", seed:1), 0xe20e8)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456", seed:seed), 0x723ab41f)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567", seed:0), 0xcf887691)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567", seed:1), 0xc6967d8)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567", seed:seed), 0xc2ae50f3)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678", seed:0), 0x7b1af730)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678", seed:1), 0xa46d3bfb)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678", seed:seed), 0xd35fd176)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789", seed:0), 0x1f34766d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789", seed:1), 0x9edb6c9b)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789", seed:seed), 0x4febbc3a)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A", seed:0), 0x772d203c)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A", seed:1), 0x9b18477a)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A", seed:seed), 0x5b4cb5b6)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB", seed:0), 0x30967301)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB", seed:1), 0x53b0aff4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB", seed:seed), 0x99306dca)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC", seed:0), 0x2b595fa)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC", seed:1), 0xa0fc1a95)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC", seed:seed), 0x58bf5c52)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD", seed:0), 0xd09d9fe)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD", seed:1), 0x610572c9)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD", seed:seed), 0x664b141d)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE", seed:0), 0xdacc797)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE", seed:1), 0xd245c4a8)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE", seed:seed), 0x43e53f36)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF", seed:0), 0x2f375968)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF", seed:1), 0x2495d14b)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF", seed:seed), 0xdde61626)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1", seed:0), 0xff6d43a9)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1", seed:1), 0xb8ac92fb)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1", seed:seed), 0x714805aa)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12", seed:0), 0x852d687c)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12", seed:1), 0xc2b7bc24)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12", seed:seed), 0xb857fa94)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123", seed:0), 0xef78a638)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123", seed:1), 0x963bd5cc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123", seed:seed), 0xe6e252b0)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234", seed:0), 0xb8939d98)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234", seed:1), 0x3cb03abc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234", seed:seed), 0x1d90636a)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345", seed:0), 0x83a9e3bc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345", seed:1), 0xd2db7873)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345", seed:seed), 0x1ddcd70f)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456", seed:0), 0xb3b65d47)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456", seed:1), 0xd6891e19)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456", seed:seed), 0xb05cb3e7)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567", seed:0), 0x929b9cc4)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567", seed:1), 0x2ea1e9bc)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567", seed:seed), 0xd18796ab)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678", seed:0), 0xe438dfb8)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678", seed:1), 0xd7f46d88)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678", seed:seed), 0x42f4b415)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789", seed:0), 0xed8d024f)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789", seed:1), 0x465b6bf7)
    XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789", seed:seed), 0xf988dace)
  }
  
  func test64OneShot() {
    XCTAssertEqual(xxHash64.digestHex("").lowercased(), "ef46db3751d8e999")
    
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
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123"), 0x3603bb1378bc6e4)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234"), 0xd69038e0b455d27d)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345"), 0x839bef46d1cc406e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456"), 0xbfcee7c87dc610f2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567"), 0x847978aeb0358851)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678"), 0xf4a1b421125fdee9)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789"), 0x750e688c4b9af2dc)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A"), 0x3c716f0adf23155a)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB"), 0xb4341041c376bcbc)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC"), 0x9dc881e927f41d54)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD"), 0x13a738537e5a21cf)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE"), 0xe62e7ea8a35d2671)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF"), 0x69074f0a41e0947f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1"), 0x107dc0d6700d877b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12"), 0xc5b09bebb8cd6667)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123"), 0xb5709dfccee2dd11)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234"), 0xc7eecc402cd62f18)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345"), 0x19cff736468f5288)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456"), 0xc25632894289e3ba)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567"), 0xcd9a7970503a478a)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678"), 0x77f6c19e210a70ff)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789"), 0xc42d1e348e671d65)
  }
  
  func test64OneShotWithSeed() {
    let seed = UInt64(0x000000007fffffff)
    
    XCTAssertEqual(xxHash64.digest("", seed:0), 0xef46db3751d8e999)
    XCTAssertEqual(xxHash64.digest("", seed:1), 0xd5afba1336a3be4b)
    XCTAssertEqual(xxHash64.digest("", seed:seed), 0x2655611cbf9cdb34)
    XCTAssertEqual(xxHash64.digest("1", seed:0), 0xb7b41276360564d4)
    XCTAssertEqual(xxHash64.digest("1", seed:1), 0x192aba5fd13fb67d)
    XCTAssertEqual(xxHash64.digest("1", seed:seed), 0xc633803a4aecc9)
    XCTAssertEqual(xxHash64.digest("12", seed:0), 0x5460f49adbe7aba2)
    XCTAssertEqual(xxHash64.digest("12", seed:1), 0x75b53fdb7dce12fa)
    XCTAssertEqual(xxHash64.digest("12", seed:seed), 0xb16cec1417b322a0)
    XCTAssertEqual(xxHash64.digest("123", seed:0), 0x3c697d223fa7e885)
    XCTAssertEqual(xxHash64.digest("123", seed:1), 0x4b805d862c3b7497)
    XCTAssertEqual(xxHash64.digest("123", seed:seed), 0x19a2f46434bc317a)
    XCTAssertEqual(xxHash64.digest("1234", seed:0), 0xd8316e61d84f6ba4)
    XCTAssertEqual(xxHash64.digest("1234", seed:1), 0xe9feb3476d8788cb)
    XCTAssertEqual(xxHash64.digest("1234", seed:seed), 0xf46ec96a022e8572)
    XCTAssertEqual(xxHash64.digest("12345", seed:0), 0xc6f2d2dd0ad64fb6)
    XCTAssertEqual(xxHash64.digest("12345", seed:1), 0x8b4dc636e784c7e5)
    XCTAssertEqual(xxHash64.digest("12345", seed:seed), 0xef98a836c0097965)
    XCTAssertEqual(xxHash64.digest("123456", seed:0), 0x2b2dc38aaa53c322)
    XCTAssertEqual(xxHash64.digest("123456", seed:1), 0xbaf38605878c2322)
    XCTAssertEqual(xxHash64.digest("123456", seed:seed), 0x4ae897dc1885851d)
    XCTAssertEqual(xxHash64.digest("1234567", seed:0), 0xd3a46e9108289359)
    XCTAssertEqual(xxHash64.digest("1234567", seed:1), 0x3a9b3211fb1bcbd2)
    XCTAssertEqual(xxHash64.digest("1234567", seed:seed), 0x743513f8fd9ef9d6)
    XCTAssertEqual(xxHash64.digest("12345678", seed:0), 0xd2d02f08cf7cfd4a)
    XCTAssertEqual(xxHash64.digest("12345678", seed:1), 0x339c66ff536000b7)
    XCTAssertEqual(xxHash64.digest("12345678", seed:seed), 0xe19d2db01f7df4ff)
    XCTAssertEqual(xxHash64.digest("123456789", seed:0), 0x8cb841db40e6ae83)
    XCTAssertEqual(xxHash64.digest("123456789", seed:1), 0x1a4cc2c9e8079790)
    XCTAssertEqual(xxHash64.digest("123456789", seed:seed), 0x5d3bba73949569e)
    XCTAssertEqual(xxHash64.digest("123456789A", seed:0), 0xd86259788ea6d316)
    XCTAssertEqual(xxHash64.digest("123456789A", seed:1), 0x67549dd3d13a19a6)
    XCTAssertEqual(xxHash64.digest("123456789A", seed:seed), 0xd29f40df8a0945ad)
    XCTAssertEqual(xxHash64.digest("123456789AB", seed:0), 0x1d1615d71699db6b)
    XCTAssertEqual(xxHash64.digest("123456789AB", seed:1), 0x9dce50837f267a20)
    XCTAssertEqual(xxHash64.digest("123456789AB", seed:seed), 0xcdd1136284934a05)
    XCTAssertEqual(xxHash64.digest("123456789ABC", seed:0), 0x226a8b511223db6c)
    XCTAssertEqual(xxHash64.digest("123456789ABC", seed:1), 0x3fe87cbe38e1a2ad)
    XCTAssertEqual(xxHash64.digest("123456789ABC", seed:seed), 0xae28ae51e1e3be34)
    XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:0), 0x7e32a5bf7d4d75)
    XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:1), 0x80473dfc05bbd680)
    XCTAssertEqual(xxHash64.digest("123456789ABCD", seed:seed), 0xf7a2dfc5fc75df85)
    XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:0), 0x1167004bac2411de)
    XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:1), 0x864bb1086f4c841b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed:seed), 0xe26a852901bc6a8e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:0), 0xa66df83f00e9202d)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:1), 0x907979bf155f0506)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed:seed), 0xe8d84202a16e482f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:0), 0x2ff14a9841f54cc3)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:1), 0x78440c0674f9217c)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed:seed), 0x512e1dc62a511c58)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:0), 0x880a293145b975a0)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:1), 0x844b03a36096e2bd)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed:seed), 0xbd8f1f044ed860af)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123", seed:0), 0x3603bb1378bc6e4)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123", seed:1), 0x2c484ce6531e25e1)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123", seed:seed), 0xe0e6ea8b26e9a6c)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234", seed:0), 0xd69038e0b455d27d)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234", seed:1), 0x1c48ab3fba020831)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234", seed:seed), 0x6f0cf5820cbd2945)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345", seed:0), 0x839bef46d1cc406e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345", seed:1), 0x5206c93016d025bc)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345", seed:seed), 0xc53b26dde6f71382)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456", seed:0), 0xbfcee7c87dc610f2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456", seed:1), 0xbebecdf4d2eb9f48)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456", seed:seed), 0xf97bb2678f244b9c)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567", seed:0), 0x847978aeb0358851)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567", seed:1), 0x79879b775fedbd51)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567", seed:seed), 0xba70754ad76be81f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678", seed:0), 0xf4a1b421125fdee9)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678", seed:1), 0x51659a820d8610fa)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678", seed:seed), 0xef8537faf7c7c182)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789", seed:0), 0x750e688c4b9af2dc)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789", seed:1), 0x1f3125a8a879c501)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789", seed:seed), 0x986070aff72bea1b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A", seed:0), 0x3c716f0adf23155a)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A", seed:1), 0xb011c4db008eb4ac)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A", seed:seed), 0x54bf4a755b395b5)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB", seed:0), 0xb4341041c376bcbc)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB", seed:1), 0x31abea712c37dce4)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB", seed:seed), 0x9c36e051f0ea20e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC", seed:0), 0x9dc881e927f41d54)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC", seed:1), 0x855d91114e1d447e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC", seed:seed), 0x4a13510496452e3f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD", seed:0), 0x13a738537e5a21cf)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD", seed:1), 0x7bca4ec0a21232ad)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD", seed:seed), 0xd5fc2bb8b7b8d906)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE", seed:0), 0xe62e7ea8a35d2671)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE", seed:1), 0x9e652322691608f2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE", seed:seed), 0x2390f5c3ff42cba2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF", seed:0), 0x69074f0a41e0947f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF", seed:1), 0x7bac1e680bbb2305)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF", seed:seed), 0x8758f66a18880d67)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1", seed:0), 0x107dc0d6700d877b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1", seed:1), 0x59ede552138d5ed3)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1", seed:seed), 0x6a5a540379caf9a5)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12", seed:0), 0xc5b09bebb8cd6667)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12", seed:1), 0xd32893db8294a189)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12", seed:seed), 0x92b54be29186551b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123", seed:0), 0xb5709dfccee2dd11)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123", seed:1), 0x5446339f8ae59264)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123", seed:seed), 0xfdd056a930bdf8a)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234", seed:0), 0xc7eecc402cd62f18)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234", seed:1), 0x47ebdbdd53feefdb)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234", seed:seed), 0xcb27b8b377efaa6c)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345", seed:0), 0x19cff736468f5288)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345", seed:1), 0x5f09f42282f48a2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345", seed:seed), 0xefe1db5b42a81c5b)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456", seed:0), 0xc25632894289e3ba)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456", seed:1), 0x5c1ef24f682e9d7f)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456", seed:seed), 0x360c8e1663649507)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567", seed:0), 0xcd9a7970503a478a)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567", seed:1), 0x15ea38a7c910cb48)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567", seed:seed), 0xc42fd82e489b804e)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678", seed:0), 0x77f6c19e210a70ff)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678", seed:1), 0x971d7434bcb3ded2)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678", seed:seed), 0x66b4dd9f9d8ea045)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789", seed:0), 0xc42d1e348e671d65)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789", seed:1), 0xc755455a09041192)
    XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789", seed:seed), 0x4b4382cf42fde13f)
  }
  
  func test3_64OneShot() {
    XCTAssertEqual(xxHash3.digest64Hex("").lowercased(), "0000000000000000")
    
    XCTAssertEqual(xxHash3.digest64("1"), 0xbfd4fee951326900)
    XCTAssertEqual(xxHash3.digest64("12"), 0x514ac985b8428585)
    XCTAssertEqual(xxHash3.digest64("123"), 0x3a5b5b075931bda5)
    XCTAssertEqual(xxHash3.digest64("1234"), 0xd0e045c4c8e4cfa8)
    XCTAssertEqual(xxHash3.digest64("12345"), 0x783d956e59f6a46e)
    XCTAssertEqual(xxHash3.digest64("123456"), 0x3c649b9848bf1f3)
    XCTAssertEqual(xxHash3.digest64("1234567"), 0xe58b731df010c85)
    XCTAssertEqual(xxHash3.digest64("12345678"), 0xc8222c8724af99a1)
    XCTAssertEqual(xxHash3.digest64("123456789"), 0xd1e71d0e0a550d)
    XCTAssertEqual(xxHash3.digest64("123456789A"), 0x3ea9996860b9d0a0)
    XCTAssertEqual(xxHash3.digest64("123456789AB"), 0x44b419b14e3b0dfb)
    XCTAssertEqual(xxHash3.digest64("123456789ABC"), 0x2c278a267e938dee)
    XCTAssertEqual(xxHash3.digest64("123456789ABCD"), 0x582653fd6fda4169)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDE"), 0x51ad39fee2918276)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF"), 0xfb28db77f56706e8)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1"), 0x9e8fadbe82bdd761)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12"), 0x3212a824b68db770)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123"), 0xe851610a1c65402c)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234"), 0xdf454bba14d0f718)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345"), 0x24aff65936aabd66)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456"), 0xd9af6e46b19817f1)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234567"), 0x92066eb29c023a36)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345678"), 0xb6458f0b55c608a3)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789"), 0x5f607369f90f729d)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789A"), 0x4fa0d1c126f52cd7)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789AB"), 0xff39c191f47f2094)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABC"), 0x8e5cd1fae1b3386a)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCD"), 0xad056c675bc31b6e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDE"), 0x9e4d4e52b3eb5b5e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF"), 0xfad8149974d64a93)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1"), 0x70a5ac4c8f22ccb)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12"), 0x3fcbfd74588ca332)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123"), 0x752224547cf69847)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234"), 0x84e980295b897e5)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345"), 0xbba92e5a949394a1)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456"), 0x1cc2d9a246b4f271)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234567"), 0x1baeb21460403a60)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345678"), 0x82f05b31d0e91863)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789"), 0x3c9a9207d4b137c2)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF"), 0xb4eafd4ffe603a99)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF"), 0x21d02847f9832971)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF"), 0xaec21fe976aca434)
  }
  
  func test3_64OneShotWithSeed() {
    let seed = UInt64(0x000000007fffffff)
    
    XCTAssertEqual(xxHash3.digest64("", seed:0), 0x0)
    XCTAssertEqual(xxHash3.digest64("", seed:1), 0x1)
    XCTAssertEqual(xxHash3.digest64("", seed:seed), 0x7fffffff)
    XCTAssertEqual(xxHash3.digest64("1", seed:0), 0xbfd4fee951326900)
    XCTAssertEqual(xxHash3.digest64("1", seed:1), 0xe985e81a4014f504)
    XCTAssertEqual(xxHash3.digest64("1", seed:seed), 0xe58a6964882dab12)
    XCTAssertEqual(xxHash3.digest64("12", seed:0), 0x514ac985b8428585)
    XCTAssertEqual(xxHash3.digest64("12", seed:1), 0xaab2a0490e310c01)
    XCTAssertEqual(xxHash3.digest64("12", seed:seed), 0x6b482270b7d6fc56)
    XCTAssertEqual(xxHash3.digest64("123", seed:0), 0x3a5b5b075931bda5)
    XCTAssertEqual(xxHash3.digest64("123", seed:1), 0xc69d32f9a2c7fa3e)
    XCTAssertEqual(xxHash3.digest64("123", seed:seed), 0xeed81d488944553b)
    XCTAssertEqual(xxHash3.digest64("1234", seed:0), 0xd0e045c4c8e4cfa8)
    XCTAssertEqual(xxHash3.digest64("1234", seed:1), 0xcdf099f7424f2fb)
    XCTAssertEqual(xxHash3.digest64("1234", seed:seed), 0xd1b93ebc64893a0f)
    XCTAssertEqual(xxHash3.digest64("12345", seed:0), 0x783d956e59f6a46e)
    XCTAssertEqual(xxHash3.digest64("12345", seed:1), 0xfaa2e0468d335d7b)
    XCTAssertEqual(xxHash3.digest64("12345", seed:seed), 0xd326c4c88de372f6)
    XCTAssertEqual(xxHash3.digest64("123456", seed:0), 0x3c649b9848bf1f3)
    XCTAssertEqual(xxHash3.digest64("123456", seed:1), 0xdd9659eacd4328ab)
    XCTAssertEqual(xxHash3.digest64("123456", seed:seed), 0x590251cc332e8766)
    XCTAssertEqual(xxHash3.digest64("1234567", seed:0), 0xe58b731df010c85)
    XCTAssertEqual(xxHash3.digest64("1234567", seed:1), 0x22776347c2b2a1e8)
    XCTAssertEqual(xxHash3.digest64("1234567", seed:seed), 0xb57d312c87f8fd40)
    XCTAssertEqual(xxHash3.digest64("12345678", seed:0), 0xc8222c8724af99a1)
    XCTAssertEqual(xxHash3.digest64("12345678", seed:1), 0x6583be989f59a440)
    XCTAssertEqual(xxHash3.digest64("12345678", seed:seed), 0xb126bfed574d361d)
    XCTAssertEqual(xxHash3.digest64("123456789", seed:0), 0xd1e71d0e0a550d)
    XCTAssertEqual(xxHash3.digest64("123456789", seed:1), 0x2aa8b9532d0ef791)
    XCTAssertEqual(xxHash3.digest64("123456789", seed:seed), 0x84d55ea81c2515a4)
    XCTAssertEqual(xxHash3.digest64("123456789A", seed:0), 0x3ea9996860b9d0a0)
    XCTAssertEqual(xxHash3.digest64("123456789A", seed:1), 0xdcbe41d323fc2ff3)
    XCTAssertEqual(xxHash3.digest64("123456789A", seed:seed), 0x23ede83f86475cb)
    XCTAssertEqual(xxHash3.digest64("123456789AB", seed:0), 0x44b419b14e3b0dfb)
    XCTAssertEqual(xxHash3.digest64("123456789AB", seed:1), 0xb9853f492550669f)
    XCTAssertEqual(xxHash3.digest64("123456789AB", seed:seed), 0x97e8d9c841028d66)
    XCTAssertEqual(xxHash3.digest64("123456789ABC", seed:0), 0x2c278a267e938dee)
    XCTAssertEqual(xxHash3.digest64("123456789ABC", seed:1), 0xe82e4772d4187707)
    XCTAssertEqual(xxHash3.digest64("123456789ABC", seed:seed), 0x3f81380014a715c2)
    XCTAssertEqual(xxHash3.digest64("123456789ABCD", seed:0), 0x582653fd6fda4169)
    XCTAssertEqual(xxHash3.digest64("123456789ABCD", seed:1), 0x3407d25e8988faf2)
    XCTAssertEqual(xxHash3.digest64("123456789ABCD", seed:seed), 0xd4d5c82441f95330)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDE", seed:0), 0x51ad39fee2918276)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDE", seed:1), 0x932dae5c4959a540)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDE", seed:seed), 0x42a05cd54a56a3d5)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF", seed:0), 0xfb28db77f56706e8)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF", seed:1), 0xfcd96bcf7a389e1b)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF", seed:seed), 0xced1ef1da8aa95ae)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1", seed:0), 0x9e8fadbe82bdd761)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1", seed:1), 0xa022bbd27ac1a14e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1", seed:seed), 0x438e75870b0bfdef)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12", seed:0), 0x3212a824b68db770)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12", seed:1), 0xc07355641cc0c192)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12", seed:seed), 0x31c4ebc5a3a94273)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123", seed:0), 0xe851610a1c65402c)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123", seed:1), 0x7a6143459fc947e9)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123", seed:seed), 0x57951cc13e237fda)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234", seed:0), 0xdf454bba14d0f718)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234", seed:1), 0x1fd943f52a3bddf0)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234", seed:seed), 0x150a8c87c652d4e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345", seed:0), 0x24aff65936aabd66)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345", seed:1), 0x549e4e39c05e0c74)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345", seed:seed), 0x54821a3dc411665b)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456", seed:0), 0xd9af6e46b19817f1)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456", seed:1), 0xc1a813d684d46571)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456", seed:seed), 0xea41e8d991feb717)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234567", seed:0), 0x92066eb29c023a36)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234567", seed:1), 0x7188bf031b64ab12)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF1234567", seed:seed), 0x3e779f87c0a73577)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345678", seed:0), 0xb6458f0b55c608a3)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345678", seed:1), 0xf5869f566ee04387)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF12345678", seed:seed), 0xf8233c40628ca9ee)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789", seed:0), 0x5f607369f90f729d)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789", seed:1), 0x3d84400a13596137)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789", seed:seed), 0xc26dacd6a0676d01)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789A", seed:0), 0x4fa0d1c126f52cd7)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789A", seed:1), 0x9ad6caed08eb1b75)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789A", seed:seed), 0xb38e1c2a4af6394d)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789AB", seed:0), 0xff39c191f47f2094)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789AB", seed:1), 0xc2148858fd9bdb51)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789AB", seed:seed), 0x465ce25320e05acd)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABC", seed:0), 0x8e5cd1fae1b3386a)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABC", seed:1), 0xc775593f9387f9ba)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABC", seed:seed), 0xb02abe5d3c7964a9)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCD", seed:0), 0xad056c675bc31b6e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCD", seed:1), 0xf5f238c8f33d13c2)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCD", seed:seed), 0x562db1a60393b711)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDE", seed:0), 0x9e4d4e52b3eb5b5e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDE", seed:1), 0xcf13c785c77c4253)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDE", seed:seed), 0x7ebefbe7e758a797)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF", seed:0), 0xfad8149974d64a93)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF", seed:1), 0x7acdca2974309e3f)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF", seed:seed), 0xf708f2bd095d7150)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1", seed:0), 0x70a5ac4c8f22ccb)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1", seed:1), 0xc0c7ceb32e7a8a3d)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1", seed:seed), 0xc98226552663600)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12", seed:0), 0x3fcbfd74588ca332)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12", seed:1), 0x40a3cfe1a3846214)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12", seed:seed), 0xe7c85bfb160984fb)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123", seed:0), 0x752224547cf69847)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123", seed:1), 0xb4f72f4f44b711b)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123", seed:seed), 0x672b62007ff92eff)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234", seed:0), 0x84e980295b897e5)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234", seed:1), 0xa0c72d7f71d35d24)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234", seed:seed), 0x34200a083ec48e6a)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345", seed:0), 0xbba92e5a949394a1)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345", seed:1), 0xee56f109e32f8736)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345", seed:seed), 0x79098f3516c8bd20)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456", seed:0), 0x1cc2d9a246b4f271)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456", seed:1), 0x3a885d5aac98f8d3)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456", seed:seed), 0xa427226c4aaabaa9)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234567", seed:0), 0x1baeb21460403a60)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234567", seed:1), 0x6fd13fc9bf98d1d9)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF1234567", seed:seed), 0xe9d55a000803da9e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345678", seed:0), 0x82f05b31d0e91863)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345678", seed:1), 0xa21fa804c6d744b0)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF12345678", seed:seed), 0x381bf786f43f869e)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789", seed:0), 0x3c9a9207d4b137c2)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789", seed:1), 0xfc9614dd289474a1)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789", seed:seed), 0x51837bd2ec5a7079)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0), 0xb4eafd4ffe603a99)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1), 0x99fceeec2399e72d)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed), 0x27c12aef0442bcef)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0), 0x21d02847f9832971)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1), 0xb27c8ec31deadb53)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed), 0x4d152bee8f696ffc)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0), 0xaec21fe976aca434)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1), 0xf13d38817a4613c5)
    XCTAssertEqual(xxHash3.digest64("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed), 0xff738252717d70)
  }
  
  func test3_128OneShot() {
    XCTAssertEqual(xxHash3.digest128Hex("").lowercased(), "00000000000000000000000000000000")
    
    XCTAssertEqual(xxHash3.digest128("")[0], 0x0)
    XCTAssertEqual(xxHash3.digest128("")[1], 0x0)
    XCTAssertEqual(xxHash3.digest128("1")[0], 0xbfd4fee951326900)
    XCTAssertEqual(xxHash3.digest128("1")[1], 0x16f62217f6b7760e)
    XCTAssertEqual(xxHash3.digest128("12")[0], 0x514ac985b8428585)
    XCTAssertEqual(xxHash3.digest128("12")[1], 0xfdf765fd7962ae27)
    XCTAssertEqual(xxHash3.digest128("123")[0], 0x3a5b5b075931bda5)
    XCTAssertEqual(xxHash3.digest128("123")[1], 0x15788b8bc97d6ca8)
    XCTAssertEqual(xxHash3.digest128("1234")[0], 0x8e713578ea77a065)
    XCTAssertEqual(xxHash3.digest128("1234")[1], 0x41915929709502f3)
    XCTAssertEqual(xxHash3.digest128("12345")[0], 0x9698e4438f7cdbe2)
    XCTAssertEqual(xxHash3.digest128("12345")[1], 0x2978b2097d8bd650)
    XCTAssertEqual(xxHash3.digest128("123456")[0], 0x55b6084d0f7e3f2b)
    XCTAssertEqual(xxHash3.digest128("123456")[1], 0xbadc034740df6c28)
    XCTAssertEqual(xxHash3.digest128("1234567")[0], 0x2e2893761c6afe8)
    XCTAssertEqual(xxHash3.digest128("1234567")[1], 0x256b02d617f01efc)
    XCTAssertEqual(xxHash3.digest128("12345678")[0], 0x5281257c46773494)
    XCTAssertEqual(xxHash3.digest128("12345678")[1], 0x8845cd7721ca41c7)
    XCTAssertEqual(xxHash3.digest128("123456789")[0], 0x7c504ed0746ffcc9)
    XCTAssertEqual(xxHash3.digest128("123456789")[1], 0xd854a155e38d334c)
    XCTAssertEqual(xxHash3.digest128("123456789A")[0], 0x65eb8a6e6a03363d)
    XCTAssertEqual(xxHash3.digest128("123456789A")[1], 0xf4772798f7c2fdf1)
    XCTAssertEqual(xxHash3.digest128("123456789AB")[0], 0xc10b0cc434f8337b)
    XCTAssertEqual(xxHash3.digest128("123456789AB")[1], 0x2cb4343fa811a289)
    XCTAssertEqual(xxHash3.digest128("123456789ABC")[0], 0x69d1844712cf7eb7)
    XCTAssertEqual(xxHash3.digest128("123456789ABC")[1], 0xe9a1f967f6aac95a)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD")[0], 0x6bec7eb536423cc1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD")[1], 0x32bc5a08ae049a86)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE")[0], 0x422fb173b4713ccc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE")[1], 0x183b99edf19bcfc6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF")[0], 0x208cfe2ef00d2aaa)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF")[1], 0x9b72015eec4abbf3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1")[0], 0x79e87cbf1cf3e1f0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1")[1], 0xc6a448dedab7f6df)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12")[0], 0x3212a824b68db770)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12")[1], 0xb1c8487428be8f41)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123")[0], 0xe851610a1c65402c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123")[1], 0x4f2f267c5d1538fe)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234")[0], 0xdf454bba14d0f718)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234")[1], 0x6cac0dda7929a2dc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345")[0], 0x24aff65936aabd66)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345")[1], 0xfb5f07080f6223cc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456")[0], 0xd9af6e46b19817f1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456")[1], 0x87ca30856954ad47)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567")[0], 0x92066eb29c023a36)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567")[1], 0xdf3838e8631f75f4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678")[0], 0xb6458f0b55c608a3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678")[1], 0x8705aa3a6c18bd8c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789")[0], 0x5f607369f90f729d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789")[1], 0x50d23d1208cf3ca0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A")[0], 0x4fa0d1c126f52cd7)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A")[1], 0x4b1b641b76bd2e7b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB")[0], 0xff39c191f47f2094)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB")[1], 0xe5a028dadeb901ea)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC")[0], 0x8e5cd1fae1b3386a)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC")[1], 0x518a3484191f8ef8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD")[0], 0xad056c675bc31b6e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD")[1], 0xa1f6a37c12db3b5e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE")[0], 0x9e4d4e52b3eb5b5e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE")[1], 0x257c7d01e545b03b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF")[0], 0xfad8149974d64a93)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF")[1], 0x3437d4e5cdc0ca86)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1")[0], 0x70a5ac4c8f22ccb)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1")[1], 0x8825bb6b2924d3e4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12")[0], 0x3fcbfd74588ca332)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12")[1], 0xe3b96e652a3145)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123")[0], 0x752224547cf69847)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123")[1], 0x55009c73e23f10f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234")[0], 0x84e980295b897e5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234")[1], 0x652134ad918632d5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345")[0], 0xbba92e5a949394a1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345")[1], 0x1c06b275a3b409e6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456")[0], 0x1cc2d9a246b4f271)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456")[1], 0x1938e77f9a74710d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567")[0], 0x1baeb21460403a60)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567")[1], 0xdf86a5f377ef44c5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678")[0], 0x82f05b31d0e91863)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678")[1], 0xff445151155abf81)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789")[0], 0x3c9a9207d4b137c2)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789")[1], 0xaeb06fcdbee72648)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[0], 0xb4eafd4ffe603a99)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[1], 0xad679fa80f3beace)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[0], 0x21d02847f9832971)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[1], 0xff3a60f4a107d4cf)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[0], 0xaec21fe976aca434)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF")[1], 0x6894dab448099f61)
  }
  
  func test3_128OneShotWithSeed() {
    let seed = UInt64(0x000000007fffffff)
    
    XCTAssertEqual(xxHash3.digest128("", seed:0)[0], 0x0)
    XCTAssertEqual(xxHash3.digest128("", seed:0)[1], 0x0)
    XCTAssertEqual(xxHash3.digest128("", seed:1)[0], 0x1)
    XCTAssertEqual(xxHash3.digest128("", seed:1)[1], 0xffffffffffffffff)
    XCTAssertEqual(xxHash3.digest128("", seed:seed)[0], 0x7fffffff)
    XCTAssertEqual(xxHash3.digest128("", seed:seed)[1], 0xffffffff80000001)
    XCTAssertEqual(xxHash3.digest128("1", seed:0)[0], 0xbfd4fee951326900)
    XCTAssertEqual(xxHash3.digest128("1", seed:0)[1], 0x16f62217f6b7760e)
    XCTAssertEqual(xxHash3.digest128("1", seed:1)[0], 0xe985e81a4014f504)
    XCTAssertEqual(xxHash3.digest128("1", seed:1)[1], 0x6e2538a6fe7d16ba)
    XCTAssertEqual(xxHash3.digest128("1", seed:seed)[0], 0xe58a6964882dab12)
    XCTAssertEqual(xxHash3.digest128("1", seed:seed)[1], 0x8b1b8fc68ef5764e)
    XCTAssertEqual(xxHash3.digest128("12", seed:0)[0], 0x514ac985b8428585)
    XCTAssertEqual(xxHash3.digest128("12", seed:0)[1], 0xfdf765fd7962ae27)
    XCTAssertEqual(xxHash3.digest128("12", seed:1)[0], 0xaab2a0490e310c01)
    XCTAssertEqual(xxHash3.digest128("12", seed:1)[1], 0x50ae7a370e66bbda)
    XCTAssertEqual(xxHash3.digest128("12", seed:seed)[0], 0x6b482270b7d6fc56)
    XCTAssertEqual(xxHash3.digest128("12", seed:seed)[1], 0xe4fc6d2a7e1b0c7f)
    XCTAssertEqual(xxHash3.digest128("123", seed:0)[0], 0x3a5b5b075931bda5)
    XCTAssertEqual(xxHash3.digest128("123", seed:0)[1], 0x15788b8bc97d6ca8)
    XCTAssertEqual(xxHash3.digest128("123", seed:1)[0], 0xc69d32f9a2c7fa3e)
    XCTAssertEqual(xxHash3.digest128("123", seed:1)[1], 0x89b61b12c2203c7)
    XCTAssertEqual(xxHash3.digest128("123", seed:seed)[0], 0xeed81d488944553b)
    XCTAssertEqual(xxHash3.digest128("123", seed:seed)[1], 0x60fb25e51ce26eff)
    XCTAssertEqual(xxHash3.digest128("1234", seed:0)[0], 0x8e713578ea77a065)
    XCTAssertEqual(xxHash3.digest128("1234", seed:0)[1], 0x41915929709502f3)
    XCTAssertEqual(xxHash3.digest128("1234", seed:1)[0], 0xdf3f2b4f85a52a82)
    XCTAssertEqual(xxHash3.digest128("1234", seed:1)[1], 0x384b33af9191d34a)
    XCTAssertEqual(xxHash3.digest128("1234", seed:seed)[0], 0x29f7acace41d88d9)
    XCTAssertEqual(xxHash3.digest128("1234", seed:seed)[1], 0x75c55bf8387d2736)
    XCTAssertEqual(xxHash3.digest128("12345", seed:0)[0], 0x9698e4438f7cdbe2)
    XCTAssertEqual(xxHash3.digest128("12345", seed:0)[1], 0x2978b2097d8bd650)
    XCTAssertEqual(xxHash3.digest128("12345", seed:1)[0], 0x22b7ee10d5a42abf)
    XCTAssertEqual(xxHash3.digest128("12345", seed:1)[1], 0xf8d9572fb21585dd)
    XCTAssertEqual(xxHash3.digest128("12345", seed:seed)[0], 0x3957a352a957771f)
    XCTAssertEqual(xxHash3.digest128("12345", seed:seed)[1], 0x778aa2118a05b24a)
    XCTAssertEqual(xxHash3.digest128("123456", seed:0)[0], 0x55b6084d0f7e3f2b)
    XCTAssertEqual(xxHash3.digest128("123456", seed:0)[1], 0xbadc034740df6c28)
    XCTAssertEqual(xxHash3.digest128("123456", seed:1)[0], 0x438227b2546a1bb2)
    XCTAssertEqual(xxHash3.digest128("123456", seed:1)[1], 0x3498261a2b264622)
    XCTAssertEqual(xxHash3.digest128("123456", seed:seed)[0], 0x716740783a5e0145)
    XCTAssertEqual(xxHash3.digest128("123456", seed:seed)[1], 0x59e287c57d15da48)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:0)[0], 0x2e2893761c6afe8)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:0)[1], 0x256b02d617f01efc)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:1)[0], 0xedaef9a2003042f8)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:1)[1], 0x1b794ef05d6a5c25)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:seed)[0], 0x73b56e2f4d65df9a)
    XCTAssertEqual(xxHash3.digest128("1234567", seed:seed)[1], 0xf7bfe3ac621e8852)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:0)[0], 0x5281257c46773494)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:0)[1], 0x8845cd7721ca41c7)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:1)[0], 0xcdf25edfe3521d83)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:1)[1], 0x94fee7f2bde7ed29)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:seed)[0], 0x5ef89da5bb195e60)
    XCTAssertEqual(xxHash3.digest128("12345678", seed:seed)[1], 0x210739b637afb716)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:0)[0], 0x7c504ed0746ffcc9)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:0)[1], 0xd854a155e38d334c)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:1)[0], 0x121100d1fb6945c9)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:1)[1], 0x1109082bc8ce910f)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:seed)[0], 0x2f9d8b9e671ef7f9)
    XCTAssertEqual(xxHash3.digest128("123456789", seed:seed)[1], 0x4ed290b3420f70b6)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:0)[0], 0x65eb8a6e6a03363d)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:0)[1], 0xf4772798f7c2fdf1)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:1)[0], 0x201f2d286f16e277)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:1)[1], 0xafd846088829171c)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:seed)[0], 0x6d3e6fe85f66ca1c)
    XCTAssertEqual(xxHash3.digest128("123456789A", seed:seed)[1], 0x2b66fdd206f7057e)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:0)[0], 0xc10b0cc434f8337b)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:0)[1], 0x2cb4343fa811a289)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:1)[0], 0xb63b174a53a4a800)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:1)[1], 0x383b43f97663c7c0)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:seed)[0], 0x1b0b21b6d145bc03)
    XCTAssertEqual(xxHash3.digest128("123456789AB", seed:seed)[1], 0x81dcae55b6d36e44)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:0)[0], 0x69d1844712cf7eb7)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:0)[1], 0xe9a1f967f6aac95a)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:1)[0], 0x636ef6b01d90cbda)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:1)[1], 0xa1877a7d3927772b)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:seed)[0], 0x4fed8c1b86e66896)
    XCTAssertEqual(xxHash3.digest128("123456789ABC", seed:seed)[1], 0x66ce5993a0f97311)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:0)[0], 0x6bec7eb536423cc1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:0)[1], 0x32bc5a08ae049a86)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:1)[0], 0xa99a5b8bc8c9ae2d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:1)[1], 0x49aa8a19c96b84de)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:seed)[0], 0x4fa69917d3a26d9e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCD", seed:seed)[1], 0x190087f46126fe80)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:0)[0], 0x422fb173b4713ccc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:0)[1], 0x183b99edf19bcfc6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:1)[0], 0xfbfe5ef43091fd4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:1)[1], 0x65bb7adfbe120d4c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:seed)[0], 0x381f62782ad9f0a8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDE", seed:seed)[1], 0x46ba4c52ce2cf82d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:0)[0], 0x208cfe2ef00d2aaa)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:0)[1], 0x9b72015eec4abbf3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:1)[0], 0xdd2065fa447893b0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:1)[1], 0x4387b3dfee532765)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:seed)[0], 0x50554db504518e64)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF", seed:seed)[1], 0xc8fb00b18f99658c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:0)[0], 0x79e87cbf1cf3e1f0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:0)[1], 0xc6a448dedab7f6df)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:1)[0], 0xbb771495aa7bdeed)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:1)[1], 0x25af1c531a87103)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:seed)[0], 0x1ccc4521cb46e9f4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1", seed:seed)[1], 0xd018cd9640a8025f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:0)[0], 0x3212a824b68db770)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:0)[1], 0xb1c8487428be8f41)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:1)[0], 0x84bd64375cf5306e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:1)[1], 0xb898b815639a1f0e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:seed)[0], 0x3964270cb37ca852)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12", seed:seed)[1], 0xd3a4c6e517054497)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:0)[0], 0xe851610a1c65402c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:0)[1], 0x4f2f267c5d1538fe)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:1)[0], 0xbce89191f8dffebb)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:1)[1], 0x1ea19fa67f2fb10c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:seed)[0], 0x2d7324f73592729e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123", seed:seed)[1], 0xa0567b9bdc9955d4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:0)[0], 0xdf454bba14d0f718)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:0)[1], 0x6cac0dda7929a2dc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:1)[0], 0x38bd3aef4cb86459)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:1)[1], 0x6c898c2b4e588857)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:seed)[0], 0x65af3d37c94d8ba9)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234", seed:seed)[1], 0x622b1880cb625594)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:0)[0], 0x24aff65936aabd66)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:0)[1], 0xfb5f07080f6223cc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:1)[0], 0xf800ce6c6c9e12f2)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:1)[1], 0x91629be0033e89d4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:seed)[0], 0x14d5975b47f3d0f1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345", seed:seed)[1], 0xb214d00b4b21c87b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:0)[0], 0xd9af6e46b19817f1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:0)[1], 0x87ca30856954ad47)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:1)[0], 0xcc4bcdb86d6f479)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:1)[1], 0xaeb928126ca862e0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:seed)[0], 0xc91f939c21af39ca)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456", seed:seed)[1], 0xc0a121385c898e3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:0)[0], 0x92066eb29c023a36)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:0)[1], 0xdf3838e8631f75f4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:1)[0], 0x3ccc3cdc5d828d2e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:1)[1], 0xe370a495f57c511a)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:seed)[0], 0x352d2853db18081f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF1234567", seed:seed)[1], 0x1e719017aa78ad6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:0)[0], 0xb6458f0b55c608a3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:0)[1], 0x8705aa3a6c18bd8c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:1)[0], 0x2491326f5e18bd51)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:1)[1], 0x186904141f9ee7f4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:seed)[0], 0x753433a5ef6137d3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF12345678", seed:seed)[1], 0x7fa477cf6ab3e0a2)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:0)[0], 0x5f607369f90f729d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:0)[1], 0x50d23d1208cf3ca0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:1)[0], 0xb94738d1e8170e54)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:1)[1], 0xab99a97c198bf7e1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:seed)[0], 0xf3960f7ebeea4186)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789", seed:seed)[1], 0x4afaa88ad2ccda24)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:0)[0], 0x4fa0d1c126f52cd7)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:0)[1], 0x4b1b641b76bd2e7b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:1)[0], 0x15a151f5157faa5c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:1)[1], 0x4a7b38092f4d53bf)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:seed)[0], 0xcc90128c4ce6c5ad)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789A", seed:seed)[1], 0x292cd36177668750)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:0)[0], 0xff39c191f47f2094)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:0)[1], 0xe5a028dadeb901ea)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:1)[0], 0x7759e49a3f1939bc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:1)[1], 0xb62114b2152687d3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:seed)[0], 0x54c36137c684134c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789AB", seed:seed)[1], 0xd0aeda9b7df62d73)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:0)[0], 0x8e5cd1fae1b3386a)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:0)[1], 0x518a3484191f8ef8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:1)[0], 0x7ae4271c971f3569)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:1)[1], 0xb63fa73be852edaf)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:seed)[0], 0x37f1499737cd79df)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABC", seed:seed)[1], 0xd60941c039d5a6e8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:0)[0], 0xad056c675bc31b6e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:0)[1], 0xa1f6a37c12db3b5e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:1)[0], 0xb9c10559b04386d9)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:1)[1], 0x6ea27551b6fdd624)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:seed)[0], 0xff4ccc04c6fbb53c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCD", seed:seed)[1], 0x1a7587ef78498514)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:0)[0], 0x9e4d4e52b3eb5b5e)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:0)[1], 0x257c7d01e545b03b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:1)[0], 0x5540bc1f65e388fc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:1)[1], 0x40e44f1ea0fe26e3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:seed)[0], 0x6c710acfa8290333)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDE", seed:seed)[1], 0xc7999c4802c8f1c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:0)[0], 0xfad8149974d64a93)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:0)[1], 0x3437d4e5cdc0ca86)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:1)[0], 0xc0e78ef91b3345dc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:1)[1], 0x94c06f2c19c1bd95)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:seed)[0], 0x42ac5aa12608e896)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF", seed:seed)[1], 0xcf7608a4ca747d17)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:0)[0], 0x70a5ac4c8f22ccb)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:0)[1], 0x8825bb6b2924d3e4)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:1)[0], 0xb336debe6f5f38ae)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:1)[1], 0x343a239d659d2d0d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:seed)[0], 0x79aa34e6a542c250)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1", seed:seed)[1], 0x4bc5c53d8cada6b1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:0)[0], 0x3fcbfd74588ca332)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:0)[1], 0xe3b96e652a3145)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:1)[0], 0xea6a24e48e2d40c1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:1)[1], 0xedef63764077120d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:seed)[0], 0x937bf2b5d54d1fe9)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12", seed:seed)[1], 0x4eabf0b1e812643d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:0)[0], 0x752224547cf69847)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:0)[1], 0x55009c73e23f10f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:1)[0], 0xb72208db02841950)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:1)[1], 0xeae0a358bb5e587f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:seed)[0], 0x4e2a5eecdade8659)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123", seed:seed)[1], 0x321738425fc3c6f9)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:0)[0], 0x84e980295b897e5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:0)[1], 0x652134ad918632d5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:1)[0], 0x8ae0c2e87b530cfc)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:1)[1], 0x1f25da9d35bd31a3)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:seed)[0], 0x382f28c1b68ebf68)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234", seed:seed)[1], 0xf262959bbe4d5dd8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:0)[0], 0xbba92e5a949394a1)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:0)[1], 0x1c06b275a3b409e6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:1)[0], 0x63287a287d8e175a)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:1)[1], 0x4ecec27afdf22fed)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:seed)[0], 0x8b866c525c1cde10)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345", seed:seed)[1], 0x348df308972ea64b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:0)[0], 0x1cc2d9a246b4f271)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:0)[1], 0x1938e77f9a74710d)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:1)[0], 0x14800c26e9a3abae)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:1)[1], 0x2123c30566d3b67b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:seed)[0], 0x149fa1abc71dd6d0)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456", seed:seed)[1], 0xb90fbf12feebb017)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:0)[0], 0x1baeb21460403a60)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:0)[1], 0xdf86a5f377ef44c5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:1)[0], 0x9293b41dce1b9017)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:1)[1], 0x2dfbf94f492f0a1b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:seed)[0], 0x918b80f2355bf0ab)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF1234567", seed:seed)[1], 0xf70f6dd079000838)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:0)[0], 0x82f05b31d0e91863)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:0)[1], 0xff445151155abf81)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:1)[0], 0x9b032a78f1ecdef5)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:1)[1], 0xeef68d8ce18a7d53)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:seed)[0], 0xcaaa2ef43867d1d7)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF12345678", seed:seed)[1], 0xf927e2f2ce305043)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:0)[0], 0x3c9a9207d4b137c2)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:0)[1], 0xaeb06fcdbee72648)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:1)[0], 0x2f1713164be5ac88)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:1)[1], 0x2273805458d37e03)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:seed)[0], 0xbd9183372b853c49)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789", seed:seed)[1], 0x544d38bf296f3e53)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[0], 0xb4eafd4ffe603a99)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[1], 0xad679fa80f3beace)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[0], 0x8b1828e6b3e08fa6)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[1], 0xb04179c10a9df59b)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[0], 0x54d1f604eee244c8)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[1], 0xd1020265ff1c3eab)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[0], 0x21d02847f9832971)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[1], 0xff3a60f4a107d4cf)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[0], 0xc642807e7ae2697f)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[1], 0xfe0cbe6bab6f9c77)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[0], 0x62fb4da607ac6b43)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[1], 0xc666993fa989a272)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[0], 0xaec21fe976aca434)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:0)[1], 0x6894dab448099f61)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[0], 0x1b8d760adf9d0c8c)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:1)[1], 0x67ee0b937acb520)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[0], 0x87717520afd31df)
    XCTAssertEqual(xxHash3.digest128("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF", seed:seed)[1], 0x6823dc649a00cd03)
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
      xxh.update("3")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123"), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234"), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345"), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456"), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567"), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678"), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789"), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A"), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB"), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC"), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD"), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE"), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF"), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1"), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12"), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123"), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234"), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345"), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456"), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567"), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678"), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789"), xxh.digest())
      
      xxh.update("ABCDEF123456789ABCDEF123456789ABCDEF123456789")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789"), xxh.digest())
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
    let seed = UInt32(0x7fffffff)
    
    do {
      let xxh = xxHash32(seed)
      
      XCTAssertEqual(xxHash32.digest("", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash32.digest("1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash32.digest("12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash32.digest("123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash32.digest("1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash32.digest("12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash32.digest("123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash32.digest("1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash32.digest("12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash32.digest("123456789", seed: seed), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash32.digest("123456789A", seed: seed), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash32.digest("123456789AB", seed: seed), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash32.digest("123456789ABC", seed: seed), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash32.digest("123456789ABCD", seed: seed), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash32.digest("123456789ABCDE", seed: seed), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789", seed: seed), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789A", seed: seed), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789AB", seed: seed), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABC", seed: seed), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCD", seed: seed), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDE", seed: seed), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789", seed: seed), xxh.digest())
      
      xxh.update("ABCDEF123456789ABCDEF123456789ABCDEF123456789")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789", seed: seed), xxh.digest())
    }
    
    do {
      let xxh = xxHash32(seed)
      xxh.update("123456789ABCDEF123")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123", seed: seed), xxh.digest())
    }
    
    do {
      let xxh = xxHash32(seed)
      xxh.update("123456789ABCDEF123456789ABCDEF123")
      XCTAssertEqual(xxHash32.digest("123456789ABCDEF123456789ABCDEF123", seed: seed), xxh.digest())
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
      xxh.update("3")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123"), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234"), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345"), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456"), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567"), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678"), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789"), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A"), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB"), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC"), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD"), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE"), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF"), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1"), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12"), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123"), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234"), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345"), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456"), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567"), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678"), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789"), xxh.digest())
      
      xxh.update("ABCDEF123456789ABCDEF123456789ABCDEF123456789")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789"), xxh.digest())
    }
    
    do {
      let xxh = xxHash64()
      xxh.update("123456789ABCDEF123")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123"), xxh.digest())
    }
    
    do {
      let xxh = xxHash64()
      xxh.update("123456789ABCDEF123456789ABCDEF123")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123"), xxh.digest())
    }
  }
  
  func test64UpdateWithSeed() {
    let seed = UInt64(0x000000007fffffff)
    
    do {
      let xxh = xxHash64(seed)
      
      XCTAssertEqual(xxHash64.digest("", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash64.digest("1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash64.digest("12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash64.digest("123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash64.digest("1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash64.digest("12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash64.digest("123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash64.digest("1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash64.digest("12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash64.digest("123456789", seed: seed), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash64.digest("123456789A", seed: seed), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash64.digest("123456789AB", seed: seed), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash64.digest("123456789ABC", seed: seed), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash64.digest("123456789ABCD", seed: seed), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash64.digest("123456789ABCDE", seed: seed), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789", seed: seed), xxh.digest())
      xxh.update("A")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789A", seed: seed), xxh.digest())
      xxh.update("B")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789AB", seed: seed), xxh.digest())
      xxh.update("C")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABC", seed: seed), xxh.digest())
      xxh.update("D")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCD", seed: seed), xxh.digest())
      xxh.update("E")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDE", seed: seed), xxh.digest())
      xxh.update("F")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF", seed: seed), xxh.digest())
      xxh.update("1")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1", seed: seed), xxh.digest())
      xxh.update("2")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12", seed: seed), xxh.digest())
      xxh.update("3")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123", seed: seed), xxh.digest())
      xxh.update("4")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234", seed: seed), xxh.digest())
      xxh.update("5")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345", seed: seed), xxh.digest())
      xxh.update("6")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456", seed: seed), xxh.digest())
      xxh.update("7")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF1234567", seed: seed), xxh.digest())
      xxh.update("8")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF12345678", seed: seed), xxh.digest())
      xxh.update("9")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789", seed: seed), xxh.digest())
      
      xxh.update("ABCDEF123456789ABCDEF123456789ABCDEF123456789")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789", seed: seed), xxh.digest())
    }
    
    do {
      let xxh = xxHash64(seed)
      xxh.update("123456789ABCDEF123")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123", seed: seed), xxh.digest())
    }
    
    do {
      let xxh = xxHash64(seed)
      xxh.update("123456789ABCDEF123456789ABCDEF123")
      XCTAssertEqual(xxHash64.digest("123456789ABCDEF123456789ABCDEF123", seed: seed), xxh.digest())
    }
  }
  
  
  
  // MARK: - Reset
  func test32Reset() {
    let seed = UInt32(0x7fffffff)
    let xxh = xxHash32()
    
    xxh.update("123456789ABCDEF")
    xxh.reset()
    XCTAssertEqual(xxh.digest(), xxHash32().digest())
    
    xxh.update("123456789ABCDEF")
    xxh.seed = seed	// Reset when setting seed.
    XCTAssertEqual(xxh.digest(), xxHash32(seed).digest())
  }
  
  func test64Reset() {
    let seed = UInt64(0x000000007fffffff)
    let xxh = xxHash64()
    
    xxh.update("123456789ABCDEF")
    xxh.reset()
    XCTAssertEqual(xxh.digest(), xxHash64().digest())
    
    xxh.update("123456789ABCDEF")
    xxh.seed = seed	// Reset when setting seed.
    XCTAssertEqual(xxh.digest(), xxHash64(seed).digest())
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
  
  
  
  // MARK: - File
  func test32File() {
    #if SWIFT_PACKAGE
    print("SwiftPM-Building skipped UnitTest that used resources.")
    #else
    let xxh = xxHash32()
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    XCTAssertEqual(xxh.digest(), 0xafc8e0c2)
    #endif
  }
  
  func test32FileWithSeed() {
    #if SWIFT_PACKAGE
    print("SwiftPM-Building skipped UnitTest that used resources.")
    #else
    let xxh = xxHash32(0x7fffffff)
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    XCTAssertEqual(xxh.digest(), 0x7d7e2195)
    #endif
  }
  
  func test64File() {
    #if SWIFT_PACKAGE
    print("SwiftPM-Building skipped UnitTest that used resources.")
    #else
    let xxh = xxHash64()
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    XCTAssertEqual(xxh.digest(), 0x843c2c4ccfbfb749)
    #endif
  }
  
  func test64FileWithSeed() {
    #if SWIFT_PACKAGE
    print("SwiftPM-Building skipped UnitTest that used resources.")
    #else
    let xxh = xxHash64(0x7fffffff)
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "alice29", ofType: "txt")!
    let data = NSData(contentsOfFile: path)! as Data
    
    let bufSize = 1024
    var index = 0
    
    repeat {
      var lastIndex = index + bufSize
      if lastIndex > data.count {
        lastIndex = index + data.count - index
      }
      
      let data2 = data[index..<lastIndex]
      xxh.update(data2)
      
      index += data2.count
      if index >= data.count {
        break
      }
    } while(true)
    
    XCTAssertEqual(xxh.digest(), 0x3e8df4f6f8de8fff)
    #endif
  }
  
  
  
  // MARK: - Canonical
  func test32Canonical() {
    var hash = UInt32(0x01234567)
    var canonical = [UInt8]()
    
    canonical = xxHash32.canonicalFromHash(hash)
    XCTAssertEqual(canonical[0], 0x01)
    XCTAssertEqual(canonical[1], 0x23)
    XCTAssertEqual(canonical[2], 0x45)
    XCTAssertEqual(canonical[3], 0x67)
    
    hash = xxHash32.hashFromCanonical(canonical)
    XCTAssertEqual(hash, 0x01234567)
  }
  
  func test64Canonical() {
    var hash = UInt64(0x0123456789ABCDEF)
    var canonical = [UInt8]()
    
    canonical = xxHash64.canonicalFromHash(hash)
    XCTAssertEqual(canonical[0], 0x01)
    XCTAssertEqual(canonical[1], 0x23)
    XCTAssertEqual(canonical[2], 0x45)
    XCTAssertEqual(canonical[3], 0x67)
    XCTAssertEqual(canonical[4], 0x89)
    XCTAssertEqual(canonical[5], 0xAB)
    XCTAssertEqual(canonical[6], 0xCD)
    XCTAssertEqual(canonical[7], 0xEF)
    
    hash = xxHash64.hashFromCanonical(canonical)
    XCTAssertEqual(hash, 0x0123456789ABCDEF)
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
