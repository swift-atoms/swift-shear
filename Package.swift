// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-shear",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [.library(name: "Shear", targets: ["Shear"])],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-axis.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-scale.git", branch: "main"),
    ],
    targets: [
        .target(name: "Shear", dependencies: [
            .product(name: "Axis", package: "swift-axis"),
            .product(name: "Scale", package: "swift-scale"),
        ]),
        .testTarget(name: "Shear Tests", dependencies: [
            .target(name: "Shear"),
            .product(name: "Scale", package: "swift-scale"),
        ]),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
