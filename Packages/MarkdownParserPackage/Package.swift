// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarkdownParserPackage",
    products: [
        .library(
            name: "MarkdownParserPackage",
            targets: ["MarkdownParserPackage"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MarkdownParserPackage",
            dependencies: []),
        .testTarget(
            name: "MarkdownParserPackageTests",
            dependencies: ["MarkdownParserPackage"]),
    ]
)
