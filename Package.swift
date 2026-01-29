//
//  Package.swift
//  wrapd
//
//  Created by Hassan Sheikha on 2026-01-29.
//

// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "wrapd",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "wrapd", targets: ["wrapd"]),
    ],
    dependencies: [
        // Add dependencies here if needed
    ],
    targets: [
        .executableTarget(
            name: "wrapd",
            dependencies: []
        ),
        .testTarget(
            name: "wrapdTests",
            dependencies: ["wrapd"]
        )
    ]
)
