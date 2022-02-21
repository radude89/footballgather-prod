// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "History",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "History",
            targets: ["History"]),
    ],
    dependencies: [
        .package(name: "UITools", path: "../../../Core/UITools"),
        .package(name: "FoundationTools", path: "../../../Core/FoundationTools")
    ],
    targets: [
        .target(
            name: "History",
            dependencies: ["UITools", "FoundationTools"]),
        .testTarget(
            name: "HistoryTests",
            dependencies: ["History"]),
    ]
)
