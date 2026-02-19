// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "CoreModels",
    platforms: [.iOS("26.0")],
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
    ],
    swiftLanguageModes: [.v6]
)
