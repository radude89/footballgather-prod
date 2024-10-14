// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "UITools",
    platforms: [.iOS(.v17)],
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
    swiftLanguageModes: [.version("6")]
)
