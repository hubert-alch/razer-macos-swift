# 兼容性矩阵

[English](compatibility.md) | [繁體中文](compatibility.zh-Hant.md) | [简体中文](compatibility.zh-Hans.md)

[返回简体中文 README](../README.zh-Hans.md)

这份矩阵根据当前的 `src/devices/*.json` 目录，以及 legacy Electron 版在 `src/main/feature/featurehelper.js` 中定义的默认功能集生成。

> 由 268 个设备 JSON profile 生成。

## 支持边界

- legacy Electron 版保留较完整的设备目录和历史功能模型。
- 原生 SwiftUI/AppKit 版采用更严格的标准：只有已接入原生 C bridge，并在 macOS 实体硬件上测试过的路径，才会列为原生已验证。
- legacy 目录中的功能代表此仓库已有对应配置；不代表每个 macOS 版本、每台实体设备的读取或写入都已验证成功。

## 原生已验证目标

| 设备 | Product ID | 原生控制 | 状态 |
| --- | --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | 识别、DPI、回报率、电池/状态 | 第一个已验证目标；当前硬件路径的读取仍可能超时 |

## 原生手柄目标

| 设备 | Product ID | 原生状态 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/接收器识别，以及经 USB 直接读取的实时输入（XInput，自动识别 Xbox 360 / Xbox One GIP 协议，映射移植自 Linux xpad，待实机验证）；震动和 LED 走输出报告。雷蛇私有设置仍需协议抓包。 |
| Razer Wolverine V3 Pro Wired 8K | `0x0A57` | 与 `0x0A3F` 相同的 XInput 直读支持（8K 有线模式），待实机验证。 |
| Razer Wolverine V3 Pro Dongle 8K | `0x0A59` | 与 `0x0A3F` 相同的 XInput 直读支持（8K 无线接收器），待实机验证。 |

## legacy 目录摘要

| 类别 | 设备数量 |
| --- | --- |
| 鼠标 | 113 |
| 键盘 | 119 |
| 鼠标垫 | 8 |
| 鼠标充电座 | 2 |
| 配件 | 15 |
| 耳机 | 8 |
| eGPU 外接盒 | 2 |
| 手柄 | 3 |

## 功能图例

| 功能 key | 说明 |
| --- | --- |
| `battery` | 电池 |
| `breathe` | 呼吸灯 |
| `brightness` | 亮度 |
| `dpi` | DPI |
| `mouseBrightness` | 鼠标亮度 |
| `none` | 关灯 / 无效果 |
| `oldMouseEffects` | 旧版鼠标灯效 |
| `pollRate` | 回报率 |
| `reactive` | 反应式 |
| `ripple` | 涟漪 |
| `spectrum` | 光谱循环 |
| `starlight` | 星光 |
| `static` | 固定颜色 |
| `waveExtended` | 扩展波浪 |
| `waveSimple` | 简易波浪 |
| `wheel` | 色轮 |

## 完整 legacy 设备目录

### 鼠标 (113)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Abyssus | `0x0042` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Abyssus 1800 | `0x0020` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Abyssus 2000 | `0x005E` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Abyssus Elite DVA Edition | `0x006A` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Abyssus Essential | `0x006B` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Abyssus V2 | `0x005B` | 固定颜色, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI |
| Razer Atheris (Receiver) | `0x0062` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Basilisk | `0x0064` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk Essential | `0x0065` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk Mobile Receiver | `0x00d4` | 关灯 / 无效果, 固定颜色, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk Mobile Wired | `0x00d3` | 关灯 / 无效果, 固定颜色, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk Ultimate | `0x0086` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk Ultimate Receiver | `0x0088` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V2 | `0x0085` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 | `0x0099` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 35K | `0x00cb` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wired | `0x00d6` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wireless | `0x00d7` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 Pro 35K Wired | `0x00cc` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 Pro 35K Wireless | `0x00cd` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 Pro Wired | `0x00aa` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 Pro Wireless | `0x00ab` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk V3 X HyperSpeed | `0x00b9` | 鼠标亮度, 回报率, DPI, 电池 |
| Razer Basilisk X HyperSpeed | `0x0083` | 回报率, DPI, 电池 |
| Razer Cobra | `0x00a3` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI |
| Razer Cobra Pro Wired | `0x00af` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Cobra Pro Wireless | `0x00b0` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder 1800 | `0x0038` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer DeathAdder 2000 | `0x004f` | 关灯 / 无效果, 呼吸灯, 鼠标亮度, 回报率, DPI |
| Razer DeathAdder 2013 | `0x0037` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer DeathAdder 3.5G | `0x0016` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer DeathAdder 3.5G Black | `0x0029` | 回报率, DPI |
| Razer DeathAdder 3500 | `0x0054` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder Chroma | `0x0043` | 固定颜色, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder Elite | `0x005C` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder Essential | `0x006E` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder Essential (2021) | `0x0098` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder Essential (White Edition) | `0x0071` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder V2 | `0x0084` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder V2 Lite | `0x00a1` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI |
| Razer DeathAdder V2 Mini | `0x008C` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder V2 Pro Wired | `0x007C` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder V2 Pro Wireless | `0x007D` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer DeathAdder V2 X HyperSpeed | `0x009c` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 | `0x00b2` | 回报率, DPI |
| Razer DeathAdder V3 HyperSpeed Wired | `0x00c4` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 HyperSpeed Wireless | `0x00c5` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 Pro Wired | `0x00b6` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 Pro Wired Alternate | `0x00c2` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 Pro Wireless | `0x00b7` | 回报率, DPI, 电池 |
| Razer DeathAdder V3 Pro Wireless Alternate | `0x00c3` | 回报率, DPI, 电池 |
| Razer DeathAdder V4 Pro Wired | `0x00be` | 回报率, DPI, 电池 |
| Razer DeathAdder V4 Pro Wireless | `0x00bf` | 回报率, DPI, 电池 |
| Razer Diamondback Chroma | `0x004C` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Hyper Polling Wireless Dongle | `0x00b3` | 回报率, DPI, 电池 |
| Razer Imperator | `0x002F` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Lancehead (Receiver) | `0x006F` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Lancehead Tournament Edition | `0x0060` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Lancehead Wired | `0x0059` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Lancehead Wireless | `0x005A` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Lancehead Wireless Wired | `0x0070` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Mamba (Receiver) | `0x0072` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Mamba 2012 Wired | `0x0024` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Mamba 2012 Wireless | `0x0025` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Mamba Elite | `0x006C` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI |
| Razer Mamba Tournament Edition | `0x0046` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Mamba Wired | `0x0044` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Mamba Wireless | `0x0045` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Mamba Wireless Wired | `0x0073` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga | `0x0015` | 关灯 / 无效果, 回报率, DPI |
| Razer Naga 2012 | `0x002E` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Naga 2014 | `0x0040` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Naga Chroma | `0x0053` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Epic | `0x001f` | 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Epic Chroma Wired | `0x003e` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Epic Chroma Wireless | `0x003f` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Hex | `0x0041` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Naga Hex (Red) | `0x0036` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Naga Hex V2 | `0x0050` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Left Handed Edition 2020 | `0x008D` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Pro - Wired | `0x008f` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Pro - Wireless | `0x0090` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga Trinity | `0x0067` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga V2 HyperSpeed Receiver | `0x00b4` | 回报率, DPI, 电池 |
| Razer Naga V2 Pro Wired | `0x00a7` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga V2 Pro Wireless | `0x00a8` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Naga X | `0x0096` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Orochi 2011 | `0x0013` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Orochi 2013 | `0x0039` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Orochi Chroma | `0x0048` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Orochi Chroma (Receiver) | `0x0094` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Orochi V2 (Bluetooth) | `0x0095` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Ouroboros | `0x0032` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Pro Click Mini Receiver | `0x009a` | 回报率, DPI, 电池 |
| Razer Pro Click Receiver | `0x0077` | 回报率, DPI, 电池 |
| Razer Pro Click V2 Vertical Edition Wired | `0x00c7` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Pro Click V2 Vertical Edition Wireless | `0x00c8` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Pro Click V2 Wired | `0x00d0` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Pro Click V2 Wireless | `0x00d1` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Pro Click Wired | `0x0080` | 回报率, DPI, 电池 |
| Razer Taipan | `0x0034` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 回报率, DPI, 电池 |
| Razer Viper | `0x0078` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Viper 8Khz | `0x0091` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Viper Mini | `0x008A` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Viper Mini SE Wired | `0x009e` | 回报率, DPI, 电池 |
| Razer Viper Mini SE Wireless | `0x009f` | 回报率, DPI, 电池 |
| Razer Viper Ultimate Wired | `0x007A` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Viper Ultimate Wireless | `0x007B` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯, 旧版鼠标灯效, 鼠标亮度, 回报率, DPI, 电池 |
| Razer Viper V2 Pro Wired | `0x00a5` | 回报率, DPI, 电池 |
| Razer Viper V2 Pro Wireless | `0x00a6` | 回报率, DPI, 电池 |
| Razer Viper V3 HyperSpeed | `0x00b8` | 回报率, DPI, 电池 |
| Razer Viper V3 Pro Wired | `0x00c0` | 回报率, DPI, 电池 |
| Razer Viper V3 Pro Wireless | `0x00c1` | 回报率, DPI, 电池 |

### 键盘 (119)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Anansi | `0x010F` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer BlackWidow 2019 | `0x0241` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Chroma | `0x0203` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Chroma Tournament Edition | `0x0209` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Chroma V2 | `0x0221` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Elite | `0x0228` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Essential | `0x0237` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Lite | `0x0235` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer BlackWidow Overwatch | `0x0211` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Stealth | `0x011B` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Stealth Edition | `0x010E` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Tournament Edition 2014 | `0x011c` |  |
| Razer BlackWidow Ultimate 2012 | `0x010D` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Ultimate 2013 | `0x011A` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow Ultimate 2016 | `0x0214` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V3 | `0x024e` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V3 Mini Hyperspeed (Wired) | `0x0258` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V3 Mini Hyperspeed (Wireless) | `0x0271` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V3 Pro (Wired) | `0x025A` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V3 Pro Wireless | `0x025c` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V3 Tenkeyless | `0x0a24` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V4 | `0x0287` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V4 75% | `0x02a5` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V4 Mini HyperSpeed Wired | `0x02b9` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V4 Mini HyperSpeed Wireless | `0x02ba` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V4 PRO | `0x028D` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wired | `0x02d7` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wireless | `0x02d5` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow V4 X | `0x0293` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer BlackWidow X Chroma | `0x0216` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow X Chroma Tournament Edition | `0x021A` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer BlackWidow X Ultimate | `0x0217` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade 14 2021 | `0x0270` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 14 2022 | `0x028c` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 14 2023 | `0x029d` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 14 2024 | `0x02b6` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 14 2025 | `0x02c5` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 15 (2018) | `0x0233` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade 15 (2018) Base Model | `0x023b` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Blade 15 (2019) Advanced | `0x023a` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade 15 (2019) Base Model | `0x0246` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Blade 15 (Mid 2019) Mercury White | `0x0245` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade 15 2023 | `0x029e` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 15 Advanced 2020 | `0x0253` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 15 Advanced 2021 | `0x0276` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 15 Advanced Early 2021 | `0x026d` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 15 Advanced Early 2022 | `0x028a` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 16 2023 | `0x029f` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 16 2025 | `0x02c6` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 17 2022 | `0x028b` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 17 Pro 2021 | `0x0279` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 17 Pro Early 2021 | `0x026e` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 18 2023 | `0x02a0` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 18 2024 | `0x02b8` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 18 2025 | `0x02c7` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade 2018 Mercury | `0x0240` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Advanced Late 2019 | `0x024b` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade Early 2020 Base | `0x0255` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Early 2021 Base | `0x026f` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Early 2022 Base | `0x027a` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Late 2016 | `0x0224` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Late 2020 Base | `0x0268` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Pro (2017) | `0x0225` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Pro 2017 FullHD | `0x022F` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Pro 2019 | `0x0234` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade Pro Early 2020 | `0x0256` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 涟漪, 色轮 |
| Razer Blade Pro Late 2016 | `0x0210` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Pro Late 2019 | `0x024c` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Blade Stealth | `0x0205` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Stealth (2019) | `0x0239` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Blade Stealth (Late 2016) | `0x0220` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Stealth (Late 2017) | `0x0232` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Stealth (Late 2019) | `0x024a` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Blade Stealth (Mid 2017) | `0x022D` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Stealth (QHD) | `0x020F` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Blade Stealth Early 2020 | `0x0252` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Stealth Late 2020 | `0x0259` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Blade Studio Edition 2019 | `0x024d` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Book 2020 | `0x026a` | 关灯 / 无效果, 固定颜色, 光谱循环, 反应式, 呼吸灯 |
| Razer Cynosa Chroma | `0x022A` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Cynosa Chroma Pro | `0x022C` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Cynosa Lite | `0x023F` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Cynosa V2 | `0x025E` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Deathstalker Chroma | `0x0204` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer DeathStalker Essential | `0x0118` |  |
| Razer Deathstalker Expert | `0x0202` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Deathstalker V2 | `0x0295` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer DeathStalker V2 Pro TKL Wired | `0x0298` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer DeathStalker V2 Pro TKL Wireless | `0x0296` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer DeathStalker V2 Pro Wired | `0x0292` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer DeathStalker V2 Pro Wireless | `0x0290` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Huntsman | `0x0227` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman Elite | `0x0226` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman Mini | `0x0257` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman Mini (JP) | `0x0269` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman Mini Analog | `0x0282` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 涟漪, 色轮 |
| Razer Huntsman Tournament Edition | `0x0243` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman V2 | `0x026c` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman V2 Analog | `0x0266` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman V2 TKL | `0x026b` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Huntsman V3 Pro | `0x02a6` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Huntsman V3 Pro 8KHz | `0x02cf` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Huntsman V3 Pro Mini | `0x02b0` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Huntsman V3 Pro TKL | `0x02a7` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮 |
| Razer Nostromo | `0x0111` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Orbweaver | `0x0113` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Orbweaver Chroma | `0x0207` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Ornata | `0x021F` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Ornata Chroma | `0x021E` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Ornata V2 | `0x025D` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |
| Razer Ornata V3 | `0x02a1` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯, 涟漪, 色轮 |
| Razer Ornata V3 Alternate | `0x028f` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯, 涟漪, 色轮 |
| Razer Ornata V3 Tenkeyless | `0x02a3` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 涟漪, 色轮 |
| Razer Ornata V3 X | `0x0294` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 涟漪, 色轮 |
| Razer Ornata V3 X Alternate | `0x02a2` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 涟漪, 色轮 |
| Razer Tartarus | `0x0201` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Tartarus Chroma | `0x0208` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度 |
| Razer Tartarus Pro | `0x0244` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 亮度, 涟漪, 色轮 |
| Razer Tartarus V2 | `0x022B` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 反应式, 呼吸灯, 星光, 涟漪, 色轮, 亮度 |

### 鼠标垫 (8)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Firefly | `0x0C00` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯, 亮度 |
| Razer Firefly Hyperflux | `0x0068` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯, 亮度 |
| Razer Firefly V2 | `0x0c04` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯, 亮度 |
| Razer Firefly V2 Pro | `0x0c08` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯 |
| Razer Goliathus Chroma | `0x0C01` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯, 亮度 |
| Razer Goliathus Chroma 3 XL | `0x0c06` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Goliathus Chroma Extended | `0x0C02` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 亮度 |
| Razer Strider Chroma | `0x0c05` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯 |

### 鼠标充电座 (2)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Mouse Charging Dock | `0x007E` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯, 电池 |
| Razer Mouse Dock Pro | `0x00a4` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |

### 配件 (15)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Base Station V2 Chroma | `0x0F20` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Charging Pad Chroma | `0x0f26` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Chroma ARGB | `0x0f1f` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Chroma Base | `0x0F08` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Chroma HDK | `0x0F09` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Chroma Mug | `0x0F07` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Laptop Stand Chroma | `0x0f0d` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Laptop Stand Chroma V2 | `0x0f2b` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Lian Li O11 Dynamic | `0x0f13` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Mouse Bungee V3 Chroma | `0x0F1D` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Nommo Chroma | `0x0517` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Nommo Pro | `0x0518` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Raptor 27 | `0x0f12` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Thunderbolt 4 Dock Chroma | `0x0F21` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |
| Razer Tomahawk ATX | `0x0f17` | 关灯 / 无效果, 固定颜色, 扩展波浪, 光谱循环, 呼吸灯 |

### 手柄 (3)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0a3f` | 经 USB 直读 XInput 实时按键/摇杆（映射移植自 Linux xpad，待实机验证）；震动和 LED 走输出报告，不声明雷蛇私有配置写入。 |
| Razer Wolverine V3 Pro Wired 8K | `0x0a57` | 与 `0x0a3f` 相同的 XInput 直读界面（8K 有线模式）；震动和 LED 走输出报告。待实机验证。 |
| Razer Wolverine V3 Pro Dongle 8K | `0x0a59` | 与 `0x0a3f` 相同的 XInput 直读界面（8K 无线接收器）；震动和 LED 走输出报告。待实机验证。 |

### 耳机 (8)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Kraken 7.1 | `0x0501` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken 7.1 | `0x0506` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken 7.1 Chroma | `0x0504` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken Kitty Edition | `0x0F19` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken Kitty V2 | `0x0560` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken Tournament Edition | `0x0520` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken Ultimate | `0x0527` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |
| Razer Kraken V2 | `0x0510` | 关灯 / 无效果, 固定颜色, 光谱循环, 呼吸灯 |

### eGPU 外接盒 (2)

| 设备 | Product ID | 目录功能 |
| --- | --- | --- |
| Razer Core | `0x0215` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯 |
| Razer Core X Chroma | `0x0f1a` | 关灯 / 无效果, 固定颜色, 简易波浪, 光谱循环, 呼吸灯 |

来源：`src/devices/*.json`；默认功能集来自 `FeatureHelper.getDefaultFeaturesFor(mainType)`。
