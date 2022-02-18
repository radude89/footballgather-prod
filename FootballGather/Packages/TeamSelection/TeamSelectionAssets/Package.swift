// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TeamSelectionAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "TeamSelectionAssets",
            targets: ["TeamSelectionAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TeamSelectionAssets",
            dependencies: []),
        .testTarget(
            name: "TeamSelectionAssetsTests",
            dependencies: ["TeamSelectionAssets"]),
    ]
)
