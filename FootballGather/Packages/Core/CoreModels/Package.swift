// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "CoreModels",
    platforms: [.iOS(.v17)],
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
    swiftLanguageModes: [.version("6")]
)
