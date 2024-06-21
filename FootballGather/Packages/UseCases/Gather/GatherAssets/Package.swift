// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "GatherAssets",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GatherAssets",
            targets: ["GatherAssets"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GatherAssets",
            dependencies: []),
        .testTarget(
            name: "GatherAssetsTests",
            dependencies: ["GatherAssets"]),
    ],
    swiftLanguageVersions: [.version("6")]
)
