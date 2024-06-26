// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "PlayerDetailsAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
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
    ],
    swiftLanguageVersions: [.version("6")]
)
