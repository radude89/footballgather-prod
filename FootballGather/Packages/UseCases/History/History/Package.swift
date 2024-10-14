// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "History",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "History",
            targets: ["History"]),
    ],
    dependencies: [
        .package(name: "HistoryAssets", path: "../HistoryAssets"),
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "History",
            dependencies: ["HistoryAssets", "UITools", "FoundationTools"]
        ),
        .testTarget(
            name: "HistoryTests",
            dependencies: [
                "History",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        ),
        .testTarget(
            name: "HistoryIntegrationTests",
            dependencies: [
                "History",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        )
    ],
    swiftLanguageModes: [.version("6")]
)
