// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "RazerMacOS",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(name: "NativeRazerCore", targets: ["NativeRazerCore"]),
    .executable(name: "RazerMacOS", targets: ["RazerMacOS"])
  ],
  targets: [
    .target(
      name: "NativeRazerBridgeC",
      cSettings: [
        .unsafeFlags(["-I", "../librazermacos/src/include"])
      ],
      linkerSettings: [
        .linkedFramework("CoreFoundation"),
        .linkedFramework("IOKit")
      ]
    ),
    .target(name: "NativeRazerCore"),
    .executableTarget(
      name: "RazerMacOS",
      dependencies: ["NativeRazerBridgeC", "NativeRazerCore"],
      path: "Sources/RazerMacOS",
      linkerSettings: [
        .linkedFramework("CoreHaptics"),
        .linkedFramework("GameController")
      ]
    ),
    .testTarget(
      name: "NativeRazerCoreTests",
      dependencies: ["NativeRazerCore"]
    ),
    .testTarget(
      name: "RazerMacOSTests",
      dependencies: ["NativeRazerBridgeC", "NativeRazerCore", "RazerMacOS"],
      path: "Tests/RazerMacOSTests"
    )
  ]
)
