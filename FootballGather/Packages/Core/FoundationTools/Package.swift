// swift-tools-version:5.10

import PackageDescription

let settings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency")
]

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
            dependencies: ["CoreModels"],
            swiftSettings: settings
        ),
        .target(
            name: "FoundationMocks",
            dependencies: ["CoreModels", "FoundationTools"],
            swiftSettings: settings
        ),
        .testTarget(
            name: "FoundationToolsTests",
            dependencies: ["FoundationTools", "FoundationMocks"],
            swiftSettings: settings
        ),
        .testTarget(
            name: "FoundationToolsIntegrationTests",
            dependencies: ["FoundationTools", "FoundationMocks"],
            swiftSettings: settings
        )
    ]
)
