// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "GatherAssets",
    defaultLocalization: "en",
    platforms: [.iOS("26.0")],
    products: [
        .library(
            name: "GatherAssets",
            targets: ["GatherAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GatherAssets",
            dependencies: []),
        .testTarget(
            name: "GatherAssetsTests",
            dependencies: ["GatherAssets"]),
    ],
    swiftLanguageModes: [.v6]
)
