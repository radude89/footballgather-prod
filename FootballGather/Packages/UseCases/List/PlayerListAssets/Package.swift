// swift-tools-version:6.0

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
    ],
    swiftLanguageVersions: [.version("6")]
)
