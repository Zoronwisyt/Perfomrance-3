// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ZoronPerformanceBooster",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ZoronPerformanceBooster",
            type: .dynamic,
            targets: ["ZoronPerformanceBooster"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ZoronPerformanceBooster",
            dependencies: [],
            path: "Sources/ZoronPerformanceBooster",
            resources: []
        )
    ]
)
