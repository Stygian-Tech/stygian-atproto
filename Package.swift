// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "atproto-auth-kit",
  platforms: [
    .macOS(.v14),
  ],
  products: [
    .library(name: "AtprotoAuthKit", targets: ["AtprotoAuthKit"]),
  ],
  dependencies: [
    .package(path: "../atproto-primitives"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.6.0"),
    .package(url: "https://github.com/apple/swift-http-types.git", from: "1.3.0"),
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
  ],
  targets: [
    .target(
      name: "AtprotoAuthKit",
      dependencies: [
        .product(name: "AtprotoPrimitives", package: "atproto-primitives"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "NIOCore", package: "swift-nio"),
      ],
      path: "Sources/AtprotoAuthKit",
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
    .testTarget(
      name: "AtprotoAuthKitTests",
      dependencies: [
        "AtprotoAuthKit",
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "NIOCore", package: "swift-nio"),
      ],
      path: "Tests/AtprotoAuthKitTests",
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
  ]
)
