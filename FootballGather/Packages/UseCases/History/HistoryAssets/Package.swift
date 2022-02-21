// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "HistoryAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "HistoryAssets",
            targets: ["HistoryAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HistoryAssets",
            dependencies: []),
        .testTarget(
            name: "HistoryAssetsTests",
            dependencies: ["HistoryAssets"]),
    ]
)
