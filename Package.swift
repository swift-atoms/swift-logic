// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-logic-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Logic Primitive",
            targets: ["Logic Primitive"]
        ),

        .library(
            name: "Logic Primitives",
            targets: ["Logic Primitives"]
        ),

        .library(
            name: "Logic Ternary Primitives",
            targets: ["Logic Ternary Primitives"]
        ),
        .library(
            name: "Logic Primitives Test Support",
            targets: ["Logic Primitives Test Support"]
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
            name: "Logic Primitive",
            dependencies: []
        ),

        .target(
            name: "Logic Ternary Primitives",
            dependencies: [
                "Logic Primitive"
            ]
        ),

        .target(
            name: "Logic Primitives",
            dependencies: [
                "Logic Primitive",
                "Logic Ternary Primitives",
            ]
        ),
        .testTarget(
            name: "Logic Primitives Tests",
            dependencies: [
                "Logic Primitives"
            ]
        ),
        .testTarget(
            name: "Logic Ternary Primitives Tests",
            dependencies: [
                "Logic Ternary Primitives",

                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
            ]
        ),

        .target(
            name: "Logic Primitives Test Support",
            dependencies: [
                "Logic Primitives"
            ],
            path: "Tests/Support"
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
