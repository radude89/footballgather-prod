// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "FoundationTools",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FoundationTools",
            targets: ["FoundationTools"]
        ),
        .library(
            name: "FoundationMocks",
            targets: ["FoundationMocks"]
        ),
    ],
    dependencies: [
        .package(name: "CoreModels", path: "../CoreModels")
    ],
    targets: [
        .target(
            name: "FoundationTools",
            dependencies: ["CoreModels"]
        ),
        .target(
            name: "FoundationMocks",
            dependencies: ["CoreModels", "FoundationTools"]
        ),
        .testTarget(
            name: "FoundationToolsTests",
            dependencies: ["FoundationTools", "FoundationMocks"]
        ),
        .testTarget(
            name: "FoundationToolsIntegrationTests",
            dependencies: ["FoundationTools", "FoundationMocks"]
        )
    ]
)
