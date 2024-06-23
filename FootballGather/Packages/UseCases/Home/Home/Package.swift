// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: "HomeAssets", path: "../HomeAssets"),
        .package(name: "History", path: "../History/History"),
        .package(name: "PlayerList", path: "../List/PlayerList"),
        .package(name: "PlayerDetails", path: "../Details/PlayerDetails"),
        .package(name: "TeamSelection", path: "../TeamSelection/TeamSelection"),
        .package(name: "Gather", path: "../Gather/Gather"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "HomeAssets",
                "History",
                "PlayerList",
                "PlayerDetails",
                "TeamSelection",
                "Gather"
            ]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ],
    swiftLanguageVersions: [.version("6")]
)
