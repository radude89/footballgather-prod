// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PlayerList",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PlayerList",
            targets: ["PlayerList"]),
    ],
    dependencies: [
        .package(name: "PlayerListAssets", path: "../PlayerListAssets"),
        .package(name: "UITools", path: "../UITools"),
        .package(name: "FoundationTools", path: "../FoundationTools")
    ],
    targets: [
        .target(
            name: "PlayerList",
            dependencies: ["PlayerListAssets", "UITools", "FoundationTools"]),
        .testTarget(
            name: "PlayerListTests",
            dependencies: ["PlayerList"]),
    ]
)
