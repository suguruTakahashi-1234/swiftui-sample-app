// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SampleAppToolsPackage",
    products: [
        .library(name: "SampleAppToolsPackage", targets: ["SampleAppToolsPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "master"),
    ],
    targets: [
        .target(name: "SampleAppToolsPackage", dependencies: []),
        .testTarget(name: "SampleAppToolsPackageTests", dependencies: ["SampleAppToolsPackage"]),
    ]
)
