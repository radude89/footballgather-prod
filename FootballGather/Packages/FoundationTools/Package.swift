// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FoundationTools",
    products: [
        .library(
            name: "FoundationTools",
            targets: ["FoundationTools"]),
    ],
    dependencies: [
        .package(name: "CoreModels", path: "../CoreModels"),
        .package(name: "Localizable", path: "../Localizable")
    ],
    targets: [
        .target(
            name: "FoundationTools",
            dependencies: ["CoreModels", "Localizable"]),
        .testTarget(
            name: "FoundationToolsTests",
            dependencies: ["FoundationTools"]),
    ]
)
