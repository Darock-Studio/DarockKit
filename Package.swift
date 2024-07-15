// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DarockKit",
    platforms: [
        .iOS(.v15), .watchOS(.v8), .macOS(.v10_15), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "DarockKit",
            targets: ["DarockKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.8.1"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "4.0.0"),
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "DarockKit",
            dependencies: [
                "Alamofire",
                "SwiftyJSON",
                "SwiftDate"
            ]
        )
    ]
)
