// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Localizable",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Localizable",
            targets: ["Localizable"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Localizable",
            dependencies: []),
        .testTarget(
            name: "LocalizableTests",
            dependencies: ["Localizable"]),
    ]
)
