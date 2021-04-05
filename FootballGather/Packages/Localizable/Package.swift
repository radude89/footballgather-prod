// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Localizable",
    defaultLocalization: "en",
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
