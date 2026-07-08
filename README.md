# JVerification iOS SDK

JVerification iOS SDK 支持通过 CocoaPods 和 Swift Package Manager 接入。

## Swift Package Manager 接入

使用 SPM 接入时，需要在 App Target 中同时添加以下两个仓库：

```text
https://github.com/jpush/jcore-sdk.git
https://github.com/jpush/jverification-sdk.git
```

并选择以下两个 Products：

```text
JCore
JVerification
```

说明：

- `JVerification` 不内置 JCore。
- `JVerification` 也不在 `Package.swift` 中声明对 JCore 的 SPM 依赖。
- App 需要自行集成并链接 `JCore`。
- 这种方式与 JPush 的 SPM 接入方式保持一致，便于多个极光 SDK 在同一个 App 中共用一份 JCore。

### Xcode 接入步骤

1. 打开 App 工程。
2. 选择 `File > Add Package Dependencies...`。
3. 添加 JCore：

   ```text
   https://github.com/jpush/jcore-sdk.git
   ```

   在 Product 选择页勾选：

   ```text
   JCore
   ```

4. 再次选择 `File > Add Package Dependencies...`。
5. 添加 JVerification：

   ```text
   https://github.com/jpush/jverification-sdk.git
   ```

   在 Product 选择页勾选：

   ```text
   JVerification
   ```

6. 确认 App Target 已同时链接 `JCore` 和 `JVerification`。

### Swift 项目调用说明

使用 SPM 接入后，Swift 代码中不要直接写：

```swift
import JVerification
```

当前 SPM 产物会完成 SDK 二进制链接，但 `JVERIFICATIONService.h` 没有以 Swift 可直接 `import JVerification` 的模块形式暴露。Swift App 需要通过 Objective-C Bridging Header 引入 SDK 头文件。

1. 在 App Target 中新增桥接头文件，例如：

   ```text
   YourApp/YourApp-Bridging-Header.h
   ```

2. 在桥接头文件中引入认证 SDK 头文件：

   ```objc
   #import "JVERIFICATIONService.h"
   ```

3. 在 App Target 的 `Build Settings` 中设置：

   ```text
   Objective-C Bridging Header = YourApp/YourApp-Bridging-Header.h
   ```

4. 在 Swift 初始化阶段调用 SDK。SwiftUI App 可以参考：

   ```swift
   import SwiftUI

   @main
   struct YourApp: App {
       init() {
           configureOnLaunch()
       }

       var body: some Scene {
           WindowGroup {
               ContentView()
           }
       }

       private func configureOnLaunch() {
           #if DEBUG
           JVERIFICATIONService.setDebug(true)
           #endif

           let config = JVAuthConfig()
           config.appKey = "替换成你的 AppKey"
           config.channel = "App Store"
           config.isProduction = false
           config.timeout = 5000
           config.authBlock = { result in
               print("JVerification setup result: \(result)")
           }

           JVERIFICATIONService.setup(with: config)
       }
   }
   ```

正式发布时，请将 `config.appKey` 替换为真实 AppKey，并按环境设置 `config.isProduction`。`JVERIFICATIONService.setDebug(true)` 建议仅在调试阶段开启。

### Package.swift 示例

如果业务工程通过 `Package.swift` 管理依赖，可以参考：

```swift
dependencies: [
    .package(url: "https://github.com/jpush/jcore-sdk.git", from: "5.4.0"),
    .package(url: "https://github.com/jpush/jverification-sdk.git", from: "3.4.7")
],
targets: [
    .target(
        name: "YourAppTarget",
        dependencies: [
            .product(name: "JCore", package: "jcore-sdk"),
            .product(name: "JVerification", package: "jverification-sdk")
        ]
    )
]
```

`from: "5.4.0"` 表示允许 Swift Package Manager 在兼容范围内解析 JCore 的最新版本，不是固定到 `5.4.0`。

上面的示例只表示依赖和链接关系。Swift 源码中调用认证 SDK 时，仍需按上一节通过 App Target 的 Objective-C Bridging Header 引入 `JVERIFICATIONService.h`。

## CocoaPods 接入

如果通过 CocoaPods Specs 发布，用户继续使用：

```ruby
pod 'JVerification'
```

如果直接通过 Git 仓库接入，可以使用：

```ruby
pod 'JVerification', :git => 'https://github.com/jpush/jverification-sdk.git', :tag => '3.4.7'
```

当前 podspec 中仍声明了：

```json
"dependencies": {
  "JCore": [
    ">= 2.1.6"
  ]
}
```

因此 CocoaPods 会按原有链路处理 JCore 依赖。

## 注意事项

- 使用 SPM 接入时，不要只添加 `JVerification`，还需要添加并链接 `JCore`。
- 如果 App 已经通过 JPush 或其它极光 SDK 集成了 JCore，请确认最终 App 中只有一份 JCore。
- 不建议在同一个 App 中混用多份不同来源的 JCore，避免重复二进制、符号冲突或运行期版本不一致。
- 接入完成后，请同时验证模拟器和真机编译。
- 本仓库中的二进制产物来自 `3.4.7` 对应的官方 SDK zip 包。
