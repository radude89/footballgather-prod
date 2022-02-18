// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PlayerDetailsAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PlayerDetailsAssets",
            targets: ["PlayerDetailsAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PlayerDetailsAssets",
            dependencies: []),
        .testTarget(
            name: "PlayerDetailsAssetsTests",
            dependencies: ["PlayerDetailsAssets"]),
    ]
)
