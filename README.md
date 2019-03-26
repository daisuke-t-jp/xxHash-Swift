<img src="https://raw.githubusercontent.com/daisuke-t-jp/xxHash-Swift/master/images/header.png" width="700"></br>
------
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20Linux-blue.svg)
[![Language Swift%204.2,%205.0](https://img.shields.io/badge/Language-Swift%204.2,%205.0-orange.svg)](https://developer.apple.com/swift)
[![Cocoapods](https://img.shields.io/cocoapods/v/xxHash-Swift.svg)](https://cocoapods.org/pods/xxHash-Swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-green.svg)](https://github.com/apple/swift-package-manager)
[![Build Status](https://travis-ci.org/daisuke-t-jp/xxHash-Swift.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/xxHash-Swift)


# Introduction

[**xxHash**](https://cyan4973.github.io/xxHash/) framework in Swift.  
A framework includes xxHash 32/64 bit functions.  
  
Original xxHash algorithm created by [Yann Collet](https://github.com/Cyan4973).
  
[Documentation](https://daisuke-t-jp.github.io/xxHash-Swift/)


# Requirements
- Platforms
  - iOS 10.0+
  - macOS 10.12+
  - tvOS 12.0+
  - Linux
- Swift 4.2, 5.0


# Installation
## Carthage
`github "daisuke-t-jp/xxHash-Swift"`

## CocoaPods
```
use_frameworks!

target 'target' do
pod 'xxHash-Swift'
end
```

## Swift Package Manager
```swift
import PackageDescription

let package = Package(
    name: "YOUR_PACKAGE_NAME",
    targets: [],
    dependencies: [
        // Swift 4.2
        .package(url: "https://github.com/daisuke-t-jp/xxHash-Swift.git", .exact("1.0.9"))

        // Swift 5.0
        .package(url: "https://github.com/daisuke-t-jp/xxHash-Swift.git", from: "1.0.10")
    ]
    targets: [
        .target(
            name: "YOUR_TARGET_NAME",
            dependencies: ["xxHash-Swift"]),
    ]
)
```


# Usage
## Import framework

```swift
import xxHash_Swift
```

## Generate digest(One-shot)
### 32bit Version
```swift
let digest = xxHash32.digest("123456789ABCDEF")
// digest -> 0x576e3cf9

// Using seed.
let digest = xxHash32.digest("123456789ABCDEF", seed: 0x7fffffff)
// digest -> 0xa7f06f9d
```

### 64bit Version
```swift
let digest = xxHash64.digest("123456789ABCDEF")
// digest -> 0xa66df83f00e9202d

// Using seed.
let digest = xxHash64.digest("123456789ABCDEF", seed: 0x000000007fffffff)
// digest -> 0xe8d84202a16e482f
```


## Generate digest(Streaming)
### 32bit Version
```swift
// Create xxHash instance
let xxh = xxHash32() // if using seed, e.g. "xxHash32(0x7fffffff)"

// Get data from file
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
   xxh.update(data2) // xxHash update
   
   index += data2.count
   if index >= data.count {
      break
   }
} while(true)

let digest = xxh.digest()
// digest -> 0xafc8e0c2
```

### 64bit Version
```swift
// Create xxHash instance
let xxh = xxHash64() // if using seed, e.g. "xxHash64(0x0000007fffffff)"

// Get data from file
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
   xxh.update(data2) // xxHash update
   
   index += data2.count
   if index >= data.count {
      break
   }
} while(true)

let digest = xxh.digest()
// digest -> 0x843c2c4ccfbfb749
```
