// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FileManagerPackage",
    products: [
        .library(
            name: "FileManagerPackage",
            targets: ["FileManagerPackage"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FileManagerPackage",
            dependencies: []
		),
        .testTarget(
            name: "FileManagerPackageTests",
            dependencies: ["FileManagerPackage"],
			resources: [.process("Resources/TestContent.md")]
		),
    ]
)
