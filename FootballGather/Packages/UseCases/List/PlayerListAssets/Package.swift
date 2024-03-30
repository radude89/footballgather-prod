// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "PlayerListAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PlayerListAssets",
            targets: ["PlayerListAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PlayerListAssets",
            dependencies: []),
        .testTarget(
            name: "PlayerListAssetsTests",
            dependencies: ["PlayerListAssets"]),
    ]
)
