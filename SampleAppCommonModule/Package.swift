// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Ref: https://twitter.com/_maiyama18/status/1631265021857783810
private extension PackageDescription.Target.Dependency {
    // Amplify
    static let amplify: Self = .product(name: "Amplify", package: "amplify-swift")
    static let awsCognitoAuthPlugin: Self = .product(name: "AWSCognitoAuthPlugin", package: "amplify-swift")
    static let awsS3StoragePlugin: Self = .product(name: "AWSS3StoragePlugin", package: "amplify-swift")
    // Firebase
    static let firebaseAuth: Self = .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
    static let firebaseAnalytics: Self = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
    static let firebaseCrashlytics: Self = .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
    static let swiftProtobuf: Self = .product(name: "SwiftProtobuf", package: "swift-protobuf")
    // Quick/Nimble
    static let quick: Self = .product(name: "Quick", package: "Quick")
    static let nimble: Self = .product(name: "Nimble", package: "Nimble")
    // Same Package module
    static let appCoreFoundation: Self = "SampleAppCoreFoundation"
    static let appDomain: Self = "SampleAppDomain"
    static let appCoreUI: Self = "SampleAppCoreUI"
    static let appFramework: Self = "SampleAppFramework"
    static let appPresentation: Self = "SampleAppPresentation"
}

private extension PackageDescription.Target.PluginUsage {
    static let swiftlint: Self = .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
    static let licensesPlugin: Self = .plugin(name: "LicensesPlugin", package: "LicensesPlugin")
}

let package = Package(
    name: "SampleAppCommonModule",
    defaultLocalization: "ja",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SampleAppCommonModule", targets: ["SampleAppCommonModule"]),
        .library(name: "SampleAppCoreFoundation", targets: ["SampleAppCoreFoundation"]),
        .library(name: "SampleAppDomain", targets: ["SampleAppDomain"]),
        .library(name: "SampleAppCoreUI", targets: ["SampleAppCoreUI"]),
        .library(name: "SampleAppFramework", targets: ["SampleAppFramework"]),
        .library(name: "SampleAppPresentation", targets: ["SampleAppPresentation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", branch: "main"),
        .package(url: "https://github.com/maiyama18/LicensesPlugin", branch: "main"),
        .package(url: "https://github.com/Quick/Quick", branch: "main"),
        .package(url: "https://github.com/Quick/Nimble", branch: "main"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "master"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", branch: "master"), // Failed to resolve dependencies Dependencies could not be resolved because no versions of 'googleappmeasurement' match the requirement 10.10.0 and 'firebase-ios-sdk' depends on 'googleappmeasurement' 10.10.0.
        .package(url: "https://github.com/aws-amplify/amplify-swift", branch: "main"),
        .package(url: "https://github.com/apple/swift-protobuf", exact: "1.25.0"),
    ],
    targets: [
        .target(
            name: "SampleAppCoreFoundation",
            dependencies: [],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppDomain",
            dependencies: [.appCoreFoundation],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppCoreUI",
            dependencies: [.appCoreFoundation],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppFramework",
            dependencies: [.appCoreFoundation, .appDomain, .firebaseAuth, .amplify, .awsCognitoAuthPlugin, .awsS3StoragePlugin, .swiftProtobuf],
            plugins: [.swiftlint]
        ),
        .target(
            name: "SampleAppPresentation",
            dependencies: [.appCoreFoundation, .appCoreUI, .appFramework],
            plugins: [.swiftlint, .licensesPlugin]
        ),
        .target(
            name: "SampleAppCommonModule",
            dependencies: [.appPresentation, .firebaseAnalytics, .firebaseCrashlytics, .amplify, .awsCognitoAuthPlugin, .awsS3StoragePlugin],
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "SampleAppCommonModuleTests",
            dependencies: [.appCoreFoundation, .appCoreUI, .appFramework, .appPresentation, .quick, .nimble],
            plugins: [.swiftlint]
        ),
    ]
)
