// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "HistoryAssets",
    defaultLocalization: "en",
    platforms: [.iOS("26.0")],
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
    ],
    swiftLanguageModes: [.v6]
)
