# 相容性矩陣

[English](compatibility.md) | [繁體中文](compatibility.zh-Hant.md) | [简体中文](compatibility.zh-Hans.md)

[返回繁體中文 README](../README.zh-Hant.md)

這份矩陣根據目前的 `src/devices/*.json` 目錄，以及 legacy Electron 版在 `src/main/feature/featurehelper.js` 內定義的預設功能集產生。

> 由 268 個裝置 JSON profile 產生。

## 支援邊界

- legacy Electron 版保留較完整的裝置目錄和歷史功能模型。
- 原生 SwiftUI/AppKit 版採用較嚴格的標準：只有已接上原生 C bridge，並在 macOS 實體硬體上測過的路徑，才會列為原生已驗證。
- legacy 目錄中的功能代表此倉庫已有對應設定；不代表每個 macOS 版本、每台實體裝置的讀回或寫入都已驗證成功。

## 原生已驗證目標

| 裝置 | Product ID | 原生控制 | 狀態 |
| --- | --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | 偵測、DPI、回報率、電池/狀態 | 第一個已驗證目標；目前硬體路徑的讀回仍可能逾時 |

## 原生手掣目標

| 裝置 | Product ID | 原生狀態 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/接收器偵測，以及經 USB 直接讀取的即時輸入（XInput，自動識別 Xbox 360 / Xbox One GIP 協定，映射移植自 Linux xpad，待實機驗證）；震動和 LED 走輸出報告。Razer 私有設定仍需協定擷取。 |
| Razer Wolverine V3 Pro Wired 8K | `0x0A57` | 與 `0x0A3F` 相同的 XInput 直讀支援（8K 有線模式），待實機驗證。 |
| Razer Wolverine V3 Pro Dongle 8K | `0x0A59` | 與 `0x0A3F` 相同的 XInput 直讀支援（8K 無線接收器），待實機驗證。 |

## legacy 目錄摘要

| 類別 | 裝置數量 |
| --- | --- |
| 滑鼠 | 113 |
| 鍵盤 | 119 |
| 滑鼠墊 | 8 |
| 滑鼠充電座 | 2 |
| 配件 | 15 |
| 耳機 | 8 |
| eGPU 外接盒 | 2 |
| 手掣 | 3 |

## 功能圖例

| 功能 key | 說明 |
| --- | --- |
| `battery` | 電池 |
| `breathe` | 呼吸燈 |
| `brightness` | 亮度 |
| `dpi` | DPI |
| `mouseBrightness` | 滑鼠亮度 |
| `none` | 關燈 / 無效果 |
| `oldMouseEffects` | 舊版滑鼠燈效 |
| `pollRate` | 回報率 |
| `reactive` | 反應式 |
| `ripple` | 漣漪 |
| `spectrum` | 光譜循環 |
| `starlight` | 星光 |
| `static` | 固定顏色 |
| `waveExtended` | 擴展波浪 |
| `waveSimple` | 簡易波浪 |
| `wheel` | 色輪 |

## 完整 legacy 裝置目錄

### 滑鼠 (113)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Abyssus | `0x0042` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Abyssus 1800 | `0x0020` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Abyssus 2000 | `0x005E` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Abyssus Elite DVA Edition | `0x006A` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Abyssus Essential | `0x006B` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Abyssus V2 | `0x005B` | 固定顏色, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI |
| Razer Atheris (Receiver) | `0x0062` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Basilisk | `0x0064` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk Essential | `0x0065` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk Mobile Receiver | `0x00d4` | 關燈 / 無效果, 固定顏色, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk Mobile Wired | `0x00d3` | 關燈 / 無效果, 固定顏色, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk Ultimate | `0x0086` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk Ultimate Receiver | `0x0088` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V2 | `0x0085` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 | `0x0099` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 35K | `0x00cb` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wired | `0x00d6` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wireless | `0x00d7` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 Pro 35K Wired | `0x00cc` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 Pro 35K Wireless | `0x00cd` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 Pro Wired | `0x00aa` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 Pro Wireless | `0x00ab` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk V3 X HyperSpeed | `0x00b9` | 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Basilisk X HyperSpeed | `0x0083` | 回報率, DPI, 電池 |
| Razer Cobra | `0x00a3` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI |
| Razer Cobra Pro Wired | `0x00af` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Cobra Pro Wireless | `0x00b0` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder 1800 | `0x0038` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer DeathAdder 2000 | `0x004f` | 關燈 / 無效果, 呼吸燈, 滑鼠亮度, 回報率, DPI |
| Razer DeathAdder 2013 | `0x0037` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer DeathAdder 3.5G | `0x0016` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer DeathAdder 3.5G Black | `0x0029` | 回報率, DPI |
| Razer DeathAdder 3500 | `0x0054` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder Chroma | `0x0043` | 固定顏色, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder Elite | `0x005C` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder Essential | `0x006E` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder Essential (2021) | `0x0098` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder Essential (White Edition) | `0x0071` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder V2 | `0x0084` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder V2 Lite | `0x00a1` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI |
| Razer DeathAdder V2 Mini | `0x008C` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder V2 Pro Wired | `0x007C` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder V2 Pro Wireless | `0x007D` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer DeathAdder V2 X HyperSpeed | `0x009c` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 | `0x00b2` | 回報率, DPI |
| Razer DeathAdder V3 HyperSpeed Wired | `0x00c4` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 HyperSpeed Wireless | `0x00c5` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 Pro Wired | `0x00b6` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 Pro Wired Alternate | `0x00c2` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 Pro Wireless | `0x00b7` | 回報率, DPI, 電池 |
| Razer DeathAdder V3 Pro Wireless Alternate | `0x00c3` | 回報率, DPI, 電池 |
| Razer DeathAdder V4 Pro Wired | `0x00be` | 回報率, DPI, 電池 |
| Razer DeathAdder V4 Pro Wireless | `0x00bf` | 回報率, DPI, 電池 |
| Razer Diamondback Chroma | `0x004C` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Hyper Polling Wireless Dongle | `0x00b3` | 回報率, DPI, 電池 |
| Razer Imperator | `0x002F` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Lancehead (Receiver) | `0x006F` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Lancehead Tournament Edition | `0x0060` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Lancehead Wired | `0x0059` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Lancehead Wireless | `0x005A` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Lancehead Wireless Wired | `0x0070` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Mamba (Receiver) | `0x0072` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Mamba 2012 Wired | `0x0024` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Mamba 2012 Wireless | `0x0025` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Mamba Elite | `0x006C` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI |
| Razer Mamba Tournament Edition | `0x0046` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Mamba Wired | `0x0044` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Mamba Wireless | `0x0045` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Mamba Wireless Wired | `0x0073` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga | `0x0015` | 關燈 / 無效果, 回報率, DPI |
| Razer Naga 2012 | `0x002E` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Naga 2014 | `0x0040` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Naga Chroma | `0x0053` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Epic | `0x001f` | 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Epic Chroma Wired | `0x003e` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Epic Chroma Wireless | `0x003f` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Hex | `0x0041` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Naga Hex (Red) | `0x0036` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Naga Hex V2 | `0x0050` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Left Handed Edition 2020 | `0x008D` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Pro - Wired | `0x008f` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Pro - Wireless | `0x0090` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga Trinity | `0x0067` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga V2 HyperSpeed Receiver | `0x00b4` | 回報率, DPI, 電池 |
| Razer Naga V2 Pro Wired | `0x00a7` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga V2 Pro Wireless | `0x00a8` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Naga X | `0x0096` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Orochi 2011 | `0x0013` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Orochi 2013 | `0x0039` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Orochi Chroma | `0x0048` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Orochi Chroma (Receiver) | `0x0094` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Orochi V2 (Bluetooth) | `0x0095` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Ouroboros | `0x0032` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Pro Click Mini Receiver | `0x009a` | 回報率, DPI, 電池 |
| Razer Pro Click Receiver | `0x0077` | 回報率, DPI, 電池 |
| Razer Pro Click V2 Vertical Edition Wired | `0x00c7` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Pro Click V2 Vertical Edition Wireless | `0x00c8` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Pro Click V2 Wired | `0x00d0` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Pro Click V2 Wireless | `0x00d1` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Pro Click Wired | `0x0080` | 回報率, DPI, 電池 |
| Razer Taipan | `0x0034` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 回報率, DPI, 電池 |
| Razer Viper | `0x0078` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Viper 8Khz | `0x0091` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Viper Mini | `0x008A` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Viper Mini SE Wired | `0x009e` | 回報率, DPI, 電池 |
| Razer Viper Mini SE Wireless | `0x009f` | 回報率, DPI, 電池 |
| Razer Viper Ultimate Wired | `0x007A` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Viper Ultimate Wireless | `0x007B` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈, 舊版滑鼠燈效, 滑鼠亮度, 回報率, DPI, 電池 |
| Razer Viper V2 Pro Wired | `0x00a5` | 回報率, DPI, 電池 |
| Razer Viper V2 Pro Wireless | `0x00a6` | 回報率, DPI, 電池 |
| Razer Viper V3 HyperSpeed | `0x00b8` | 回報率, DPI, 電池 |
| Razer Viper V3 Pro Wired | `0x00c0` | 回報率, DPI, 電池 |
| Razer Viper V3 Pro Wireless | `0x00c1` | 回報率, DPI, 電池 |

### 鍵盤 (119)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Anansi | `0x010F` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer BlackWidow 2019 | `0x0241` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Chroma | `0x0203` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Chroma Tournament Edition | `0x0209` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Chroma V2 | `0x0221` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Elite | `0x0228` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Essential | `0x0237` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Lite | `0x0235` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer BlackWidow Overwatch | `0x0211` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Stealth | `0x011B` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Stealth Edition | `0x010E` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Tournament Edition 2014 | `0x011c` |  |
| Razer BlackWidow Ultimate 2012 | `0x010D` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Ultimate 2013 | `0x011A` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow Ultimate 2016 | `0x0214` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V3 | `0x024e` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V3 Mini Hyperspeed (Wired) | `0x0258` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V3 Mini Hyperspeed (Wireless) | `0x0271` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V3 Pro (Wired) | `0x025A` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V3 Pro Wireless | `0x025c` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V3 Tenkeyless | `0x0a24` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V4 | `0x0287` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V4 75% | `0x02a5` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V4 Mini HyperSpeed Wired | `0x02b9` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V4 Mini HyperSpeed Wireless | `0x02ba` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V4 PRO | `0x028D` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wired | `0x02d7` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wireless | `0x02d5` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow V4 X | `0x0293` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer BlackWidow X Chroma | `0x0216` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow X Chroma Tournament Edition | `0x021A` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer BlackWidow X Ultimate | `0x0217` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade 14 2021 | `0x0270` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 14 2022 | `0x028c` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 14 2023 | `0x029d` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 14 2024 | `0x02b6` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 14 2025 | `0x02c5` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 15 (2018) | `0x0233` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade 15 (2018) Base Model | `0x023b` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Blade 15 (2019) Advanced | `0x023a` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade 15 (2019) Base Model | `0x0246` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Blade 15 (Mid 2019) Mercury White | `0x0245` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade 15 2023 | `0x029e` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 15 Advanced 2020 | `0x0253` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 15 Advanced 2021 | `0x0276` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 15 Advanced Early 2021 | `0x026d` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 15 Advanced Early 2022 | `0x028a` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 16 2023 | `0x029f` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 16 2025 | `0x02c6` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 17 2022 | `0x028b` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 17 Pro 2021 | `0x0279` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 17 Pro Early 2021 | `0x026e` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 18 2023 | `0x02a0` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 18 2024 | `0x02b8` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 18 2025 | `0x02c7` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade 2018 Mercury | `0x0240` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Advanced Late 2019 | `0x024b` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade Early 2020 Base | `0x0255` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Early 2021 Base | `0x026f` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Early 2022 Base | `0x027a` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Late 2016 | `0x0224` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Late 2020 Base | `0x0268` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Pro (2017) | `0x0225` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Pro 2017 FullHD | `0x022F` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Pro 2019 | `0x0234` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade Pro Early 2020 | `0x0256` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 漣漪, 色輪 |
| Razer Blade Pro Late 2016 | `0x0210` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Pro Late 2019 | `0x024c` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Blade Stealth | `0x0205` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Stealth (2019) | `0x0239` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Blade Stealth (Late 2016) | `0x0220` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Stealth (Late 2017) | `0x0232` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Stealth (Late 2019) | `0x024a` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Blade Stealth (Mid 2017) | `0x022D` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Stealth (QHD) | `0x020F` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Blade Stealth Early 2020 | `0x0252` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Stealth Late 2020 | `0x0259` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Blade Studio Edition 2019 | `0x024d` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Book 2020 | `0x026a` | 關燈 / 無效果, 固定顏色, 光譜循環, 反應式, 呼吸燈 |
| Razer Cynosa Chroma | `0x022A` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Cynosa Chroma Pro | `0x022C` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Cynosa Lite | `0x023F` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Cynosa V2 | `0x025E` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Deathstalker Chroma | `0x0204` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer DeathStalker Essential | `0x0118` |  |
| Razer Deathstalker Expert | `0x0202` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Deathstalker V2 | `0x0295` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer DeathStalker V2 Pro TKL Wired | `0x0298` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer DeathStalker V2 Pro TKL Wireless | `0x0296` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer DeathStalker V2 Pro Wired | `0x0292` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer DeathStalker V2 Pro Wireless | `0x0290` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Huntsman | `0x0227` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman Elite | `0x0226` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman Mini | `0x0257` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman Mini (JP) | `0x0269` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman Mini Analog | `0x0282` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 漣漪, 色輪 |
| Razer Huntsman Tournament Edition | `0x0243` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman V2 | `0x026c` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman V2 Analog | `0x0266` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman V2 TKL | `0x026b` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Huntsman V3 Pro | `0x02a6` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Huntsman V3 Pro 8KHz | `0x02cf` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Huntsman V3 Pro Mini | `0x02b0` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Huntsman V3 Pro TKL | `0x02a7` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪 |
| Razer Nostromo | `0x0111` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Orbweaver | `0x0113` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Orbweaver Chroma | `0x0207` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Ornata | `0x021F` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Ornata Chroma | `0x021E` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Ornata V2 | `0x025D` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |
| Razer Ornata V3 | `0x02a1` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈, 漣漪, 色輪 |
| Razer Ornata V3 Alternate | `0x028f` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈, 漣漪, 色輪 |
| Razer Ornata V3 Tenkeyless | `0x02a3` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 漣漪, 色輪 |
| Razer Ornata V3 X | `0x0294` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 漣漪, 色輪 |
| Razer Ornata V3 X Alternate | `0x02a2` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 漣漪, 色輪 |
| Razer Tartarus | `0x0201` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Tartarus Chroma | `0x0208` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度 |
| Razer Tartarus Pro | `0x0244` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 亮度, 漣漪, 色輪 |
| Razer Tartarus V2 | `0x022B` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 反應式, 呼吸燈, 星光, 漣漪, 色輪, 亮度 |

### 滑鼠墊 (8)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Firefly | `0x0C00` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈, 亮度 |
| Razer Firefly Hyperflux | `0x0068` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈, 亮度 |
| Razer Firefly V2 | `0x0c04` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈, 亮度 |
| Razer Firefly V2 Pro | `0x0c08` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈 |
| Razer Goliathus Chroma | `0x0C01` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈, 亮度 |
| Razer Goliathus Chroma 3 XL | `0x0c06` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Goliathus Chroma Extended | `0x0C02` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 亮度 |
| Razer Strider Chroma | `0x0c05` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈 |

### 滑鼠充電座 (2)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Mouse Charging Dock | `0x007E` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈, 電池 |
| Razer Mouse Dock Pro | `0x00a4` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |

### 配件 (15)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Base Station V2 Chroma | `0x0F20` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Charging Pad Chroma | `0x0f26` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Chroma ARGB | `0x0f1f` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Chroma Base | `0x0F08` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Chroma HDK | `0x0F09` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Chroma Mug | `0x0F07` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Laptop Stand Chroma | `0x0f0d` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Laptop Stand Chroma V2 | `0x0f2b` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Lian Li O11 Dynamic | `0x0f13` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Mouse Bungee V3 Chroma | `0x0F1D` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Nommo Chroma | `0x0517` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Nommo Pro | `0x0518` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Raptor 27 | `0x0f12` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Thunderbolt 4 Dock Chroma | `0x0F21` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |
| Razer Tomahawk ATX | `0x0f17` | 關燈 / 無效果, 固定顏色, 擴展波浪, 光譜循環, 呼吸燈 |

### 手掣 (3)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0a3f` | 經 USB 直讀 XInput 即時按鍵/搖桿（映射移植自 Linux xpad，待實機驗證）；震動和 LED 走輸出報告，不聲稱 Razer 私有設定寫入。 |
| Razer Wolverine V3 Pro Wired 8K | `0x0a57` | 與 `0x0a3f` 相同的 XInput 直讀介面（8K 有線模式）；震動和 LED 走輸出報告。待實機驗證。 |
| Razer Wolverine V3 Pro Dongle 8K | `0x0a59` | 與 `0x0a3f` 相同的 XInput 直讀介面（8K 無線接收器）；震動和 LED 走輸出報告。待實機驗證。 |

### 耳機 (8)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Kraken 7.1 | `0x0501` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken 7.1 | `0x0506` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken 7.1 Chroma | `0x0504` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken Kitty Edition | `0x0F19` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken Kitty V2 | `0x0560` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken Tournament Edition | `0x0520` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken Ultimate | `0x0527` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |
| Razer Kraken V2 | `0x0510` | 關燈 / 無效果, 固定顏色, 光譜循環, 呼吸燈 |

### eGPU 外接盒 (2)

| 裝置 | Product ID | 目錄功能 |
| --- | --- | --- |
| Razer Core | `0x0215` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈 |
| Razer Core X Chroma | `0x0f1a` | 關燈 / 無效果, 固定顏色, 簡易波浪, 光譜循環, 呼吸燈 |

來源：`src/devices/*.json`；預設功能集來自 `FeatureHelper.getDefaultFeaturesFor(mainType)`。
