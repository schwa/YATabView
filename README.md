# YATabView
# YATabView

YATabView is a SwiftUI library that provides customizable tab views and pickers for macOS and iOS applications. It allows you to create tabbed interfaces with ease, supporting various customization options.

## Features

- Customizable tab views
- Customizable pickers
- Support for macOS and iOS
- SwiftUI integration

## Installation

To install YATabView, add it to your `Package.swift` file:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourProjectName",
    dependencies: [
        .package(url: "https://github.com/yourusername/YATabView.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["YATabView"])
    ]
)
