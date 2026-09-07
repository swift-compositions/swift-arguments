// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-arguments",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Command Primitive",
            targets: ["Command Primitive"]
        ),

        .library(
            name: "Command Core",
            targets: ["Command Core"]
        ),
        .library(
            name: "Command Schema",
            targets: ["Command Schema"]
        ),
        .library(
            name: "Command Help",
            targets: ["Command Help"]
        ),
        .library(
            name: "Command Runner",
            targets: ["Command Runner"]
        ),
        .library(
            name: "Argument Standard Library Integration",
            targets: ["Argument Standard Library Integration"]
        ),

        .library(
            name: "Command",
            targets: ["Command"]
        ),

        .library(
            name: "Command Test Support",
            targets: ["Command Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-argument.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-affine.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-text.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ieee/swift-ieee-1003.git", branch: "main"),
        .package(
            url: "https://github.com/swift-molecules/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-serializer.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-compositions/swift-environment.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-process.git", branch: "main"),
    ],
    targets: [

        .target(
            name: "Command Primitive",
            dependencies: []
        ),

        .target(
            name: "Argument Standard Library Integration",
            dependencies: [
                .product(name: "Argument", package: "swift-argument")
            ]
        ),

        .target(
            name: "Command Core",
            dependencies: [
                "Command Primitive",
                "Argument Standard Library Integration",
                .product(name: "Argument", package: "swift-argument"),
                .product(name: "Text", package: "swift-text"),
                .product(name: "Ordinal Primitive", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "IEEE_1003", package: "swift-ieee-1003"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),

        .target(
            name: "Command Schema",
            dependencies: [
                "Command Core",
                "Argument Standard Library Integration",
                .product(name: "Argument", package: "swift-argument"),
                .product(name: "Affine Carrier", package: "swift-affine"),
                .product(name: "Affine Tagged", package: "swift-affine"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Ordinal Primitive", package: "swift-ordinal"),
                .product(name: "Ordinal Tagged", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Text", package: "swift-text"),
                .product(name: "Environment", package: "swift-environment"),
            ]
        ),

        .target(
            name: "Command Help",
            dependencies: [
                "Command Schema",
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),

        .target(
            name: "Command Runner",
            dependencies: [
                "Command Core",
                "Command Schema",
                "Command Help",
                .product(name: "Process", package: "swift-process"),
            ]
        ),

        .target(
            name: "Command",
            dependencies: [
                "Command Primitive",
                "Command Core",
                "Command Schema",
                "Command Help",
                "Command Runner",
                "Argument Standard Library Integration",
            ]
        ),

        .target(
            name: "Command Test Support",
            dependencies: [
                "Command",
                .product(
                    name: "Argument Test Support",
                    package: "swift-argument"
                ),
                .product(name: "IEEE_1003 Test Support", package: "swift-ieee-1003"),
                .product(name: "Environment", package: "swift-environment"),
            ],
            path: "Tests/Support",
            exclude: ["Runner Helper"]
        ),

        .executableTarget(
            name: "command-runner-helper",
            dependencies: ["Command"],
            path: "Tests/Support/Runner Helper"
        ),

        .testTarget(
            name: "Command Core Tests",
            dependencies: ["Command Test Support"]
        ),
        .testTarget(
            name: "Command Schema Tests",
            dependencies: ["Command Test Support"]
        ),
        .testTarget(
            name: "Command Help Tests",
            dependencies: ["Command Test Support"]
        ),
        .testTarget(
            name: "Command Integration Tests",
            dependencies: [
                "Command Test Support",

                "command-runner-helper",
                .product(name: "Process", package: "swift-process"),
            ]
        ),
        .testTarget(
            name: "Argument Standard Library Integration Tests",
            dependencies: ["Command Test Support"]
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
