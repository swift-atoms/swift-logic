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
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-standard-library-extensions.git",
            branch: "main"
        )
    ],
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
        .testTarget(
            name: "Logic Tests",
            dependencies: [
                .target(name: "Logic")
            ]
        ),
        .testTarget(
            name: "Logic Ternary Tests",
            dependencies: [
                .target(name: "Logic Ternary"),

                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
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
