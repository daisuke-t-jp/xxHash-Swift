<img src="https://github.com/daisuke-t-jp/xxHash-Swift/blob/master/doc/header.png" width="700"></br>
------
![Platform](https://img.shields.io/badge/Platform-iOS%2010.0+%20%7C%20macOS%2010.12+%20%7C%20tvOS%2012.0+-blue.svg)
[![Language Swift%204.2](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)
[![Cocoapods](https://img.shields.io/cocoapods/v/xxHash-Swift.svg)](https://cocoapods.org/pods/xxHash-Swift)
[![Build Status](https://travis-ci.org/daisuke-t-jp/xxHash-Swift.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/xxHash-Swift)


# Introduction

This is [xxHash](https://github.com/Cyan4973/xxHash/) framework in Swift.  
Framework include xxHash 32/64 bit functions.  
  
Original xxHash algorithm created by [Yann Collet](https://github.com/Cyan4973).
  
Reference:
- [xxHash](https://cyan4973.github.io/xxHash/)



# Install
## Carthage
`github "daisuke-t-jp/xxHash-Swift"`

## CocoaPods
```
use_frameworks!

target 'target' do
pod 'xxHash-Swift'
end
```


# Usage
## Import framework

```swift
import xxHash_Swift
```

## Generate Hash(One-shot)
### 32bit Version
```swift
let hash = xxHash32.digest("123456789ABCDEF")
// hash -> 0x576e3cf9

// Using seed.
let hash = xxHash32.digest("123456789ABCDEF", seed: 0x7fffffff)
// hash -> 0xa7f06f9d
```

### 64bit Version
```swift
let hash = xxHash64.digest("123456789ABCDEF")
// hash -> 0xa66df83f00e9202d

// Using seed.
let hash = xxHash64.digest("123456789ABCDEF", seed: 0x000000007fffffff)
// hash -> 0xe8d84202a16e482f
```

