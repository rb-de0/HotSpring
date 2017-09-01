// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "HotSpring",
    targets: [
        Target(name: "HotSpring"),
        Target(name: "JustHTTPClient", dependencies: ["HotSpring"])
    ],
    dependencies: [
        .Package(url: "https://github.com/JustHTTP/Just.git", majorVersion: 0, minor: 5)
    ]
)
