// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "IonSwift",
    platforms: [
      .iOS(.v10),
      .macOS(.v10_12),
      .watchOS(.v3),
      .tvOS(.v10),
    ],
    products: [
        .library(
            name: "IonSwift",
            targets: ["IonSwift"]
        ),
    ],
    dependencies: [  .package(url: "https://github.com/outfoxx/PotentCodables.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IonSwift",
            dependencies: ["PotentCodables"]
        ),
        .testTarget(
            name: "IonSwiftTests",
            dependencies: ["IonSwift"]
        ),
    ]
)
