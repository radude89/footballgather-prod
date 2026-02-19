// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "HomeAssets",
    defaultLocalization: "en",
    platforms: [.iOS("26.0")],
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
    ],
    swiftLanguageModes: [.v6]
)
