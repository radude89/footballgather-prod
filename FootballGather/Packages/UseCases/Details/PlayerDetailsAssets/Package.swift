// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "PlayerDetailsAssets",
    defaultLocalization: "en",
    platforms: [.iOS("26.0")],
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
    swiftLanguageModes: [.v6]
)
