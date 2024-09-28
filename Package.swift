// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DarockKit",
    platforms: [
        .iOS(.v16), .watchOS(.v9), .macOS(.v11), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "DarockKit",
            targets: ["DarockKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.8.1"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "DarockKit",
            dependencies: [
                "Alamofire",
                "SwiftyJSON"
            ]
        )
    ]
)
