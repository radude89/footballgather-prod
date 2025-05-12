// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "TeamSelectionAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
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
    ],
    swiftLanguageModes: [.v6]
)
