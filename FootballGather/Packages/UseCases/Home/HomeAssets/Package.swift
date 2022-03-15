// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "HomeAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HomeAssets",
            targets: ["HomeAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HomeAssets",
            dependencies: []),
        .testTarget(
            name: "HomeAssetsTests",
            dependencies: ["HomeAssets"]),
    ]
)
