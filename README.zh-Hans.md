# Razer macOS

[English](README.md) | [繁體中文](README.zh-Hant.md) | [简体中文](README.zh-Hans.md)

Razer macOS 是一个独立开源的 macOS Razer 外设控制 app。它现在以原生 SwiftUI/AppKit app 为主，底层继续使用现有的 `librazermacos` IOKit/HID 驱动代码，legacy Electron 实现仅作为兼容性参考保留。

当前开发重点，是把 OpenRazer 导入的新设备数据真正落到 macOS 可用的控制路径上，第一个原生验证目标是 Razer DeathAdder V3 Pro。

## 项目意义

Razer macOS 的意义，是给 macOS 上的 Razer 外设控制留下一条开放、可审计、可继续维护的路径。很多 Razer 外设功能本质上是 USB/HID protocol 命令，OpenRazer 与 razer-macos 等社区项目已经积累了大量设备 metadata 和行为记录。这个项目把这些工作整理成一个原生 macOS app，让用户和开发者可以检查、修复、扩展，而不是完全依赖封闭的设备管理软件。

本项目与 Razer 官方无关联，也不会掩盖当前限制。如果你的设备已经被官方支持，并且你需要官方支持、官方模块或保修相关流程，Razer Synapse for Mac 仍然是更合适的选择。Razer macOS 的重点是本地设备控制、透明兼容性数据、基于 OpenRazer 的新设备适配，以及一个轻量的 macOS 菜单栏体验，让社区可以持续补位。

## 与官方 Razer Synapse for Mac 的差异

Razer 现在提供 [Razer Synapse for Mac](https://mysupport.razer.com/app/answers/detail/a_id/15479/~/razer-synapse-for-mac-support-%26-faqs)，面向运行 macOS Ventura 13 及以上的 Apple silicon Mac。官方设备支持以 Razer 的 [supported and compatible device list](https://mysupport.razer.com/app/answers/detail/a_id/14809/~/razer-synapse-for-mac-supported-and-compatible-devices) 为准；官方说明中也明确提到，不支持或配置不匹配的设备可能无法被识别，或只能使用受限功能。

| 维度 | 官方 Razer Synapse for Mac | Razer macOS |
| --- | --- | --- |
| 项目归属 | Razer 第一方软件 | 独立社区项目 |
| 源码模式 | 闭源产品软件 | 开源 app、bridge 与设备 metadata |
| 平台目标 | Apple silicon Mac，macOS Ventura 13+ | universal `arm64` + `x86_64` 原生 app，目前目标 macOS 14+ |
| 设备策略 | Razer 官方维护的支持设备清单 | OpenRazer/legacy 设备目录，加上原生硬件验证 |
| 适合场景 | 已支持设备、Macro/Linked Games 等官方模块、第一方支持 | 本地控制、协议透明、未支持设备实验、社区持续维护 |
| 支持预期 | 官方 Razer 支持路径 | 社区 best-effort 支持，并明确记录限制 |

## 当前状态

- `RazerMacOS` 中已有原生 SwiftUI/AppKit app shell
- macOS 菜单栏常驻状态项
- 原生 Settings 窗口，支持通过 `ServiceManagement` 注册 Launch at Login，并提供 macOS Login Items 快捷入口
- 原生界面支持英文、简体中文、繁体中文语言选择
- 原生 DPI 与回报率控制
- bridge 可以从硬件读取时显示电池/状态
- Swift 到 `librazermacos` 的 C bridge
- 原生 release 打包脚本，可生成 universal Developer ID 签名 zip/dmg artifacts
- GitHub Actions workflow，可生成已签名、已公证的 GitHub Releases
- `src/devices` 设备目录已更新，目前有 268 个设备 JSON profile
- legacy Electron app 保留为参考实现和 fallback

## 兼容设备与功能

此仓库有两层支持：

- legacy Electron app 保留原 razer-macos/OpenRazer 工作的广泛设备目录。`src/devices` 当前有 268 个设备 JSON profile，legacy UI 仍保留历史的颜色、亮度、状态、键盘、鼠标、鼠标垫、dock、eGPU、耳机、手柄与笔记本相关逻辑。
- 原生 app 的硬件验证标准更严格。只有 SwiftUI/AppKit 界面、C bridge、macOS 硬件行为都已接好并测试过的设备，才会列入原生已验证清单。DeathAdder V3 Pro 是第一个原生已验证控制目标；这不是完整原生支持矩阵，也不代表项目只支持一款鼠标。

完整兼容性矩阵：

- [English compatibility matrix](docs/compatibility.md)
- [繁體中文相容性矩陣](docs/compatibility.zh-Hant.md)
- [简体中文兼容性矩阵](docs/compatibility.zh-Hans.md)

原生已验证控制目标：

| 设备 | Product ID | 原生控制 |
| --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | 识别、DPI、回报率、电池/状态 |

原生手柄目标：

| 设备 | Product ID | 原生状态 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/接收器识别，以及经 USB 直接读取的实时输入（XInput，自动识别 Xbox 360 / Xbox One GIP 协议，映射移植自 Linux xpad，待实机验证）；震动和 LED 走输出报告。雷蛇私有配置文件/按键映射仍需协议抓包。 |
| Razer Wolverine V3 Pro Wired 8K | `0x0A57` | 与 `0x0A3F` 相同的 XInput 直读支持（8K 有线模式），待实机验证。 |
| Razer Wolverine V3 Pro Dongle 8K | `0x0A59` | 与 `0x0A3F` 相同的 XInput 直读支持（8K 无线接收器），待实机验证。 |

legacy 目录覆盖：

| 设备类别 | 数量 | 目录功能类型 |
| --- | ---: | --- |
| 鼠标 | 113 | 固定颜色、光谱/呼吸/反应式效果、鼠标亮度、DPI、回报率、电池 |
| 键盘 | 119 | 固定颜色、波浪/光谱/反应式/呼吸/星光/涟漪/色轮效果、亮度 |
| 鼠标垫 | 8 | 固定颜色、波浪/光谱/呼吸效果、亮度 |
| 鼠标充电座 | 2 | 固定颜色、光谱/呼吸效果、电池 |
| 配件 | 15 | 固定颜色、扩展波浪、光谱/呼吸效果 |
| 耳机 | 8 | 固定颜色、光谱/呼吸效果 |
| eGPU 外接盒 | 2 | 固定颜色、波浪/光谱/呼吸效果 |
| 手柄 | 3 | USB 识别及 macOS Game Controller 实时输入；电量、震动和灯光按系统能力启用 |

目录使用的功能 key 包括：`static`、`spectrum`、`breathe`、`reactive`、`starlight`、`ripple`、`wheel`、`brightness`、`mouseBrightness`、`dpi`、`pollRate`、`battery`。每款设备的完整功能列表请看完整兼容性矩阵。

小键盘：Tartarus 系列（Tartarus `0x0201`、Tartarus Chroma `0x0208`、Tartarus V2 `0x022B`、Tartarus Pro `0x0244`）支持完整的键盘功能集，涟漪/色轮效果按设备实际矩阵尺寸渲染（V2 为 4x6，Pro 为 1x21）。

## 已知硬件限制

在当前测试机器上，原生 bridge 与 legacy Node addon 都可以通过 `librazermacos` 识别 DeathAdder V3 Pro。

原生硬件扫描输出：

```text
productId=0x00B7 internalDeviceId=0 dpi=0 pollingRate=0
count=1
```

设备可以被识别，但此硬件路径的 DPI、回报率与电池读取命令仍可能超时。原生 UI 会在读取为 `0` 时使用安全默认值，明确显示设置读取超时，并只把写入命令标示为已通过 bridge 送出。

## 原生 app

构建并打开原生 app：

```sh
./script/build_and_run.sh
```

构建、打开并验证 app process 启动：

```sh
./script/build_and_run.sh --verify
```

通过原生 C bridge 扫描已连接的 Razer 鼠标：

```sh
./script/build_and_run.sh --scan-hardware
```

运行 Swift 测试：

```sh
swift test --package-path RazerMacOS
```

原生 app 在主窗口关闭后仍会保持运行。可从菜单栏项目、Dock 或 Razer command menu 重新打开。Launch at Login 与语言选择可在原生 Settings 窗口中设置。

## Release 打包

创建本地原生 release artifacts：

```sh
APP_VERSION=0.4.18 MACOS_SIGNING_MODE=auto ./script/package_native.sh
```

如果要生成 Developer ID 签名的本地包，请先确认登录钥匙串里已经安装 `Developer ID Application` 身份，然后运行：

```sh
APP_VERSION=0.4.18 MACOS_SIGNING_MODE=required ./script/package_native.sh
```

脚本会写出：

- `dist/release/RazerMacOS-<version>-macOS.zip`
- `dist/release/RazerMacOS-<version>-macOS.dmg`
- `dist/release/SHA256SUMS.txt`

默认 release 打包会构建 `arm64` + `x86_64` universal binary。只有制作本地诊断包时才建议覆盖 `NATIVE_MACOS_ARCHS`。

`.dmg` 内会包含 `Razer macOS.app`、`Applications` 快捷方式，以及提示用户把 app 拖到 Applications 的 Finder 背景图。

Ad-hoc 包只适合本地测试：

```sh
APP_VERSION=0.4.18 MACOS_SIGNING_MODE=adhoc ./script/package_native.sh
```

公开下载版本应使用 Developer ID 签名并完成 Apple 公证。推送 `v*` tag，或手动运行 `Razer macOS Release` workflow 时，`.github/workflows/native-release.yml` 会构建 GitHub Release。

需要配置的仓库 secrets：

| Secret | 用途 |
| --- | --- |
| `MACOS_CERTIFICATE_P12_BASE64` | Developer ID Application `.p12` 的 base64 内容 |
| `MACOS_CERTIFICATE_PASSWORD` | `.p12` 文件密码 |
| `MACOS_CODESIGN_IDENTITY` | 当 keychain 里有多个 Developer ID 身份时，用于明确指定签名身份 |
| `APPLE_API_KEY_BASE64` | 用于公证的 App Store Connect API key `.p8` 的 base64 内容 |
| `APPLE_API_KEY_ID` | App Store Connect API key id |
| `APPLE_API_ISSUER_ID` | App Store Connect issuer id |

secrets 配好后，可用命令行发布：

```sh
git tag v0.4.18
git push fork v0.4.18
```

也可以在 GitHub Actions 里用 workflow dispatch，输入 `version=0.4.18`。workflow 会运行 Swift 测试、签名原生 app 与 disk image、提交 Apple 公证、staple app 与 disk image、上传构建 artifacts，并发布 GitHub Release assets。

## Legacy Electron app

原 Electron app 会保留在仓库中，直到原生 app 逐项补齐功能。它仍提供历史菜单栏 UI、颜色效果、状态管理与更广的设备覆盖。在其他设备类别完成原生移植并于 macOS 上验证前，它仍是兼容性参考。

安装 Node 依赖：

```sh
yarn
```

运行 Electron 开发 app：

```sh
yarn dev
```

修改驱动后重建原生 Node addon：

```sh
yarn rebuild
```

编译 Electron app：

```sh
yarn compile
```

构建发行包：

```sh
yarn dist
```

## 架构

此仓库当前有两层 app，共用同一套驱动 lineage：

- `RazerMacOS/` 包含新的 SwiftUI/AppKit macOS app。
- `RazerMacOS/Sources/NativeRazerBridgeC/` 将 C 驱动函数暴露给 Swift。
- `librazermacos/` 包含低层 Razer USB/HID protocol 实现。
- `src/` 包含 legacy Electron UI、state manager、菜单栏 app 与 Node addon integration。
- `src/devices/` 包含由 OpenRazer 与原 razer-macos 工作导入并维护的设备 profile。

长期来看，SwiftUI/AppKit app 应成为主要 macOS UI，因为它更自然地贴合菜单栏行为、Launch at Login、签名、公证与 IOKit/HID integration。

## 设备支持政策

新设备支持应以 OpenRazer 设备定义为基础，并在可能时以实体硬件验证。对于手上没有的设备，仓库可以先导入 ID 与 capability metadata，但 UI 控制应保持保守，直到对应硬件路径被测试过。

其他设备功能应按 capability 逐步从 legacy app 移植，而不是一次复制整个旧界面：

1. 鼠标控制：DPI、回报率、电池、充电，以及 receiver/wired pairing 路径。
2. 灯光控制：固定颜色、光谱/循环效果、亮度区域与设备特定效果限制。
3. 状态管理：启动/刷新状态、菜单栏设备操作与持久化。
4. 键盘与配件控制：profile、layout、亮度与设备特定功能 gate。
5. 发行打包：维护已签名并公证的原生 app artifacts、hardened runtime 与清楚的 macOS 权限说明。

发行打包现在已通过 `script/package_native.sh` 与 `.github/workflows/native-release.yml` 接好。它不是缺少的设备控制功能，也不是缺少的 Launch at Login 功能；使用 `./script/build_and_run.sh` 做本地开发不需要完成 packaging。

在 capability 尚未接上原生 C bridge 并用真实设备验证前，应记录为 legacy-supported，而不是 native-supported。

DeathAdder V3 Pro 路径下一个 driver-level 任务，是改善或替换 DPI、回报率与电池状态读取会超时的命令。

## 安装备注

面向用户的安装方式，是从 GitHub Releases 下载最新已签名并公证的原生 `.dmg` 或 `.zip`。本地开发请用 `./script/build_and_run.sh` 从 source 运行。

legacy Electron packaging flow 仍保留在仓库中作为参考，但原生 SwiftUI/AppKit app 是主要 release 目标。

## Credits

此项目基于以下工作：

- [1kc/razer-macos](https://github.com/1kc/razer-macos)
- [openrazer/openrazer](https://github.com/openrazer/openrazer)
- [osx-razer-blade](https://github.com/kprinssu/osx-razer-blade)
- [osx-razer-led](https://github.com/dylanparker/osx-razer-led)
