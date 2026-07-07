// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "jverification-sdk",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(
            name: "JVerification",
            targets: [
                "JVerification",
                "EAccountApiSDK",
                "OAuth",
                "TYRZUISDK",
                "JVerificationLinker"
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "JVerification",
            path: "jverification-ios-3.4.7.xcframework"
        ),
        .binaryTarget(
            name: "EAccountApiSDK",
            path: "EAccountApiSDK.xcframework"
        ),
        .binaryTarget(
            name: "OAuth",
            path: "OAuth.xcframework"
        ),
        .binaryTarget(
            name: "TYRZUISDK",
            path: "TYRZUISDK.xcframework"
        ),
        .target(
            name: "JVerificationLinker",
            dependencies: [
                "JVerification",
                "EAccountApiSDK",
                "OAuth",
                "TYRZUISDK"
            ],
            path: "Sources/JVerificationLinker",
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("UIKit"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CFNetwork"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreAudio"),
                .linkedFramework("Security"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("MobileCoreServices"),
                .linkedFramework("WebKit"),
                .linkedLibrary("sqlite3.0"),
                .linkedLibrary("z"),
                .linkedLibrary("resolv"),
                .linkedLibrary("c++.1")
            ]
        )
    ]
)
