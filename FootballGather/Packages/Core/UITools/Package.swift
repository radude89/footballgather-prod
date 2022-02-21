// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "UITools",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "UITools",
            targets: ["UITools"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UITools",
            dependencies: []),
        .testTarget(
            name: "UIToolsTests",
            dependencies: ["UITools"]),
    ]
)
