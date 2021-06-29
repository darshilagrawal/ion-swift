// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "IonSwift",
    products: [
        .library(
            name: "IonSwift",
            targets: ["IonSwift"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IonSwift",
            dependencies: []
        ),
        .testTarget(
            name: "IonSwiftTests",
            dependencies: ["IonSwift"]
        ),
    ]
)
