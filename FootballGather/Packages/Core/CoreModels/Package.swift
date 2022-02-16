// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CoreModels",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CoreModels",
            targets: ["CoreModels"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreModels",
            dependencies: []),
        .testTarget(
            name: "CoreModelsTests",
            dependencies: ["CoreModels"]),
    ]
)
