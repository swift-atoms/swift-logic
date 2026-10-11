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
        .library(name: "Logic", targets: ["Logic"]),

        .library(name: "Logic Foundation Integration", targets: ["Logic Foundation Integration"]),
        .library(name: "Logic Test Support", targets: ["Logic Test Support"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Logic",
            dependencies: [
            ],
            path: "Sources/Logic"
        ),
        
        .target(
            name: "Logic Foundation Integration",
            dependencies: [
                .target(name: "Logic"),
            ],
            path: "Sources/Logic Foundation Integration"
        ),
        .target(
            name: "Logic Test Support",
            dependencies: [
                .target(name: "Logic"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Logic Tests",
            dependencies: [
                .target(name: "Logic"),
                .target(name: "Logic Test Support"),
            ],
            path: "Tests/Logic Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
