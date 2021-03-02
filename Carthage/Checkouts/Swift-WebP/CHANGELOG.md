# Change Log

All notable changes to this project will be documented in this file.
`WebP` adheres to [Semantic Versioning](http://semver.org/).

## v0.5.0 (incomming)

## v0.4.0

### Enhanced

* Bump embeded libwebp version to v1.1.0 (was v1.0.3)

## v0.3.0

* Added `WebPDecoder.encode(RGBA cgImage: CGImage, ...)` and so on for ainame/Swift-WebP#40

## v0.2.0

### Enhanced

* Make WebPImageInspector publicly exposed
* Added `WebPDecoder.decode(toUIImage:, options:)` and `WebPDecoder.decode(toNSImage:, options:)`
* Bump embeded libwebp version to v1.0.3 (was v1.0.0)
* Add -fembed-bitcode flag to CFLAGS when compiling libwebp for iOS

## v0.1.0

### Changed

* Add WebPImageInspector internally

### Bug fix

* Fixed a memory issue in WebPDecoder+Platform.swift


## v0.0.10

### Changed

* Support swift-tools-version 5.0 to build with swift package manager

## v0.0.9

### Changed

* Support Xcode 10.2's build and Swift 5

## v0.0.8

### Bug fix

Fixed wrong file paths of WebPDecoder

## v0.0.7

### Changed

* Added WebPDecoder

### Removed

* WebPSimple.decode

## v0.0.7

### Changed

Support Xcode10 and Swift4.2 (nothing changed at all)

## v0.0.5

### Changed

* Update libwebp v0.60 -> v1.0.0
* Now WebPEncoder supports iOS platform

### Bug fix

* Handle use_argb flag properly

### Removed

* WebPSimple.encode
