// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-logic",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Logic",
            targets: ["Logic"]
        ),

        .library(
            name: "Logic Ternary",
            targets: ["Logic Ternary"]
        ),
        .library(
            name: "Logic Standard Library Integration",
            targets: ["Logic Standard Library Integration"]
        ),
    ],
    dependencies: [],
    targets: [

        .target(
            name: "Logic",
            dependencies: []
        ),

        .target(
            name: "Logic Ternary",
            dependencies: [
                .target(name: "Logic")
            ]
        ),
        .target(
            name: "Logic Standard Library Integration",
            dependencies: [
                .target(name: "Logic Ternary")
            ]
        ),
        .testTarget(
            name: "Logic Ternary Tests",
            dependencies: [
                .target(name: "Logic Ternary"),
                .target(name: "Logic Standard Library Integration"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
