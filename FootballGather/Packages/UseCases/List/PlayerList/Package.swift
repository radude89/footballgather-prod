// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "PlayerList",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "PlayerList",
            targets: ["PlayerList"]),
    ],
    dependencies: [
        .package(name: "PlayerListAssets", path: "../PlayerListAssets"),
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "PlayerList",
            dependencies: ["PlayerListAssets", "UITools", "FoundationTools"]
        ),
        .testTarget(
            name: "PlayerListTests",
            dependencies: [
                "PlayerList",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        ),
        .testTarget(
            name: "PlayerListIntegrationTests",
            dependencies: [
                "PlayerList",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        )
    ],
    swiftLanguageModes: [.version("6")]
)
