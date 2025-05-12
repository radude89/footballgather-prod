// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "PlayerListAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
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
    ],
    swiftLanguageModes: [.v6]
)
