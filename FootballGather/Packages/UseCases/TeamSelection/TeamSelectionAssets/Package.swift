// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "TeamSelectionAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
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
    swiftLanguageModes: [.version("6")]
)
