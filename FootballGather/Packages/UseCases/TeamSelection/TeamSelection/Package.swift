// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "TeamSelection",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "TeamSelection",
            targets: ["TeamSelection"]),
    ],
    dependencies: [
        .package(name: "TeamSelectionAssets", path: "../TeamSelectionAssets"),
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "TeamSelection",
            dependencies: ["TeamSelectionAssets", "UITools", "FoundationTools"]),
        .testTarget(
            name: "TeamSelectionTests",
            dependencies: ["TeamSelection"]),
    ],
    swiftLanguageModes: [.v6]
)
