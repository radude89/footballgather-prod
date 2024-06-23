// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Gather",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Gather",
            targets: ["Gather"]),
    ],
    dependencies: [
        .package(name: "GatherAssets", path: "../GatherAssets"),
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "Gather",
            dependencies: ["GatherAssets", "UITools", "FoundationTools"]
        ),
        .testTarget(
            name: "GatherTests",
            dependencies: [
                "Gather",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        ),
        .testTarget(
            name: "GatherIntegrationTests",
            dependencies: [
                "Gather",
                .product(name: "FoundationMocks", package: "FoundationTools")
            ]
        )
    ],
    swiftLanguageVersions: [.version("6")]
)
