// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "FoundationTools",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FoundationTools",
            targets: ["FoundationTools"]),
    ],
    dependencies: [
        .package(name: "CoreModels", path: "../CoreModels")
    ],
    targets: [
        .target(
            name: "FoundationTools",
            dependencies: ["CoreModels"]),
        .testTarget(
            name: "FoundationToolsTests",
            dependencies: ["FoundationTools"]),
    ]
)
