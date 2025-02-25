// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "HomeAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
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
    swiftLanguageModes: [.version("6")]
)
