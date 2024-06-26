// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "HistoryAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
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
    swiftLanguageVersions: [.version("6")]
)
