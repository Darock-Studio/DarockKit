// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DarockKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DarockKit",
            targets: ["DarockKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", exact: "5.5.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "4.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DarockKit",
            dependencies: [
                "Alamofire",
                "SwiftyJSON"
            ]
        )
    ]
)
