// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-tab-bar",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "TabBarModule", targets: ["TabBarModule"])
    ],
    targets: [
        .target(
            name: "TabBarModule",
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .testTarget(name: "TabBarTests", dependencies: ["TabBarModule"]),
    ]
)
