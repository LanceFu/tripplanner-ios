// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TripPlannerCore",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "TripPlannerCore", targets: ["TripPlannerCore"])
    ],
    targets: [
        .target(name: "TripPlannerCore"),
        .testTarget(name: "TripPlannerCoreTests", dependencies: ["TripPlannerCore"])
    ]
)
