// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "atproto-auth-kit",
  platforms: [
    .macOS(.v14),
  ],
  products: [
    .library(name: "ATProtoAuthKit", targets: ["ATProtoAuthKit"]),
  ],
  dependencies: [
    .package(path: "../atproto-primitive-kit"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.6.0"),
    .package(url: "https://github.com/apple/swift-http-types.git", from: "1.3.0"),
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
  ],
  targets: [
    .target(
      name: "ATProtoAuthKit",
      dependencies: [
        .product(name: "ATProtoPrimitiveKit", package: "atproto-primitive-kit"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "NIOCore", package: "swift-nio"),
      ],
      path: "Sources/ATProtoAuthKit",
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
    .testTarget(
      name: "ATProtoAuthKitTests",
      dependencies: [
        "ATProtoAuthKit",
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "NIOCore", package: "swift-nio"),
      ],
      path: "Tests/ATProtoAuthKitTests",
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
  ]
)
