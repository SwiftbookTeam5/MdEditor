// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkLayerPackage",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetworkLayerPackage",
            targets: ["NetworkLayerPackage"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkLayerPackage",
            dependencies: []),
        .testTarget(
            name: "NetworkLayerPackageTests",
            dependencies: ["NetworkLayerPackage"]),
    ]
)
