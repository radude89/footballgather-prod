// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PlayerDetails",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PlayerDetails",
            targets: ["PlayerDetails"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PlayerDetails",
            dependencies: []),
        .testTarget(
            name: "PlayerDetailsTests",
            dependencies: ["PlayerDetails"]),
    ]
)
