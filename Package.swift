// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux) || os(macOS) || os(iOS) || os(tvOS)
let package = Package(
  name: "xxHash-Swift",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "xxHash-Swift",
      targets: ["xxHash_Swift"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "xxHash_Swift",
      dependencies: [],
      path: "Sources/xxHash/",
      exclude: ["xxHash.xcodeproj", "README.md", "Sources/xxHash/Info.plist", "Sources/xxHash/xxHash.h"]),
    .testTarget(
      name: "xxHashTests",
      dependencies: ["xxHash_Swift"]),
  ],
  swiftLanguageVersions: [.v5]
)
#else
fatalError("Unsupported OS")
#endif
