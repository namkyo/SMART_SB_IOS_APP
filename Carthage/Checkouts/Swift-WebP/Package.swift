// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebP",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v8),
        .macOS(SupportedPlatform.MacOSVersion.v10_13)
    ],
    products: [
        .library(name: "WebP", targets: ["WebP"]),
    ],
    targets: [
        .systemLibrary(name: "CWebP", pkgConfig: "libwebp", providers: [.brew(["webp"])]),
        .target(name: "WebP", dependencies: ["CWebP"]),
        .testTarget(name: "WebPTests", dependencies: ["WebP"]),
    ]
)
