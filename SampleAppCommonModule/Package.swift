// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Ref: https://twitter.com/_maiyama18/status/1631265021857783810
private extension PackageDescription.Target.Dependency {
    static let sampleAppCoreFoundation: Self = "SampleAppCoreFoundation"
    static let sampleAppDomain: Self = "SampleAppDomain"
    static let sampleAppCoreUI: Self = "SampleAppCoreUI"
    static let sampleAppFramework: Self = "SampleAppFramework"
}

private extension PackageDescription.Target.PluginUsage {
    static let swiftlint: Self = .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
}

let package = Package(
    name: "SampleAppCommonModule",
    defaultLocalization: "ja",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "SampleAppCommonModule", targets: ["SampleAppCommonModule"]),
        .library(name: "SampleAppCoreFoundation", targets: ["SampleAppCoreFoundation"]),
        .library(name: "SampleAppDomain", targets: ["SampleAppDomain"]),
        .library(name: "SampleAppCoreUI", targets: ["SampleAppCoreUI"]),
        .library(name: "SampleAppFramework", targets: ["SampleAppFramework"]),
        .library(name: "SampleAppPresentation", targets: ["SampleAppPresentation"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/realm/SwiftLint", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SampleAppCoreFoundation",
            dependencies: [],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppDomain",
            dependencies: ["SampleAppCoreFoundation"],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppCoreUI",
            dependencies: ["SampleAppCoreFoundation"],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppFramework",
            dependencies: ["SampleAppCoreFoundation", "SampleAppDomain"],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppPresentation",
            dependencies: ["SampleAppCoreFoundation", "SampleAppCoreUI", "SampleAppFramework"],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppCommonModule",
            dependencies: ["SampleAppPresentation"]
        ),
        .testTarget(
            name: "SampleAppCommonModuleTests",
            dependencies: ["SampleAppCoreFoundation", "SampleAppCoreUI", "SampleAppFramework", "SampleAppPresentation"],
            plugins: [.swiftlint]
        ),
    ]
)
