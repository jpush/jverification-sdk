# 验证记录

## 来源

- Podspec：`JVerification.podspec.json`
- 版本：`3.4.7`
- SDK zip：`https://sdkfiledl.jiguang.cn/cocoapods/jverification/JVerification-iOS-3.4.7.zip`
- 当前 podspec source：`https://github.com/jpush/jverification-sdk.git`，tag `3.4.7`

## 二进制产物

本仓库中的二进制产物来自上面的 SDK zip。

包含的产物：

- `jverification-ios-3.4.7.xcframework`
- `EAccountApiSDK.xcframework`
- `OAuth.xcframework`
- `TYRZUISDK.xcframework`

本仓库不包含 JCore。Swift Package Manager 用户需要单独添加 `https://github.com/jpush/jcore-sdk.git`，并在 App Target 中链接 `JCore`。

## 本地检查

已完成检查：

- `pod ipc spec JVerification.podspec.json`
- `swift package describe`
- `swift package dump-package`

SwiftPM 解析结果：

- Package name：`jverification-sdk`
- Product：`JVerification`
- Package dependencies：无
- Binary targets：
  - `JVerification`
  - `EAccountApiSDK`
  - `OAuth`
  - `TYRZUISDK`
- Linker target：
  - `JVerificationLinker`

## 发布前建议验证

发布 tag 前，建议使用真实 iOS App Target 验证：

- 添加 `https://github.com/jpush/jcore-sdk.git`
- 通过本地 Package 或 Git Package 添加本仓库
- App Target 同时链接 `JCore` 和 `JVerification`
- 验证模拟器编译
- 验证真机编译
- 验证 Objective-C 能正常引入 `JVERIFICATIONService.h`
- 如果业务 App 使用 Swift，验证 Swift 工程中的集成表现
