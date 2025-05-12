// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "UITools",
    platforms: [.iOS(.v18)],
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
    ],
    swiftLanguageModes: [.v6]
)
