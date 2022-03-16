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
        .package(name: "PlayerDetailsAssets", path: "../PlayerDetailsAssets"),
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "PlayerDetails",
            dependencies: ["PlayerDetailsAssets", "UITools", "FoundationTools"]
        ),
        .testTarget(
            name: "PlayerDetailsTests",
            dependencies: [
                "PlayerDetails",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        ),
        .testTarget(
            name: "PlayerDetailsIntegrationTests",
            dependencies: [
                "PlayerDetails",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        )
    ]
)
