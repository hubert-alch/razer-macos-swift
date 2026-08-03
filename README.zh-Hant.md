# Razer macOS

[English](README.md) | [繁體中文](README.zh-Hant.md) | [简体中文](README.zh-Hans.md)

Razer macOS 是一個獨立開源的 macOS Razer 周邊控制 app。它現在以原生 SwiftUI/AppKit app 為主，底層繼續使用既有的 `librazermacos` IOKit/HID 驅動程式碼，legacy Electron 實作僅作為相容性參考保留。

目前的開發重點，是把 OpenRazer 匯入的新裝置資料真正落到 macOS 可用的控制路徑上，第一個原生驗證目標是 Razer DeathAdder V3 Pro。

## 專案意義

Razer macOS 的意義，是為 macOS 上的 Razer 周邊控制保留一條開放、可審計、可繼續維護的路徑。很多 Razer 周邊功能本質上是 USB/HID protocol 指令，OpenRazer 與 razer-macos 等社群專案已經累積大量裝置 metadata 與行為記錄。這個專案把這些工作整理成一個原生 macOS app，讓使用者與開發者可以檢查、修復、擴展，而不是完全依賴封閉的裝置管理軟體。

本專案與 Razer 官方無關，也不會掩蓋目前限制。如果你的裝置已被官方支援，而且你需要官方支援、官方模組或保固相關流程，Razer Synapse for Mac 仍然是更合適的選擇。Razer macOS 的重點是本地裝置控制、透明相容性資料、基於 OpenRazer 的新裝置適配，以及一個輕量的 macOS menu-bar 體驗，讓社群可以持續補位。

## 與官方 Razer Synapse for Mac 的差異

Razer 現在提供 [Razer Synapse for Mac](https://mysupport.razer.com/app/answers/detail/a_id/15479/~/razer-synapse-for-mac-support-%26-faqs)，面向執行 macOS Ventura 13 及以上的 Apple silicon Mac。官方裝置支援以 Razer 的 [supported and compatible device list](https://mysupport.razer.com/app/answers/detail/a_id/14809/~/razer-synapse-for-mac-supported-and-compatible-devices) 為準；官方說明中亦明確提到，不支援或配置不匹配的裝置可能無法被偵測，或只能使用受限功能。

| 維度 | 官方 Razer Synapse for Mac | Razer macOS |
| --- | --- | --- |
| 專案歸屬 | Razer 第一方軟體 | 獨立社群專案 |
| 源碼模式 | 閉源產品軟體 | 開源 app、bridge 與裝置 metadata |
| 平台目標 | Apple silicon Mac，macOS Ventura 13+ | universal `arm64` + `x86_64` 原生 app，目前目標 macOS 14+ |
| 裝置策略 | Razer 官方維護的支援裝置清單 | OpenRazer/legacy 裝置目錄，加上原生硬體驗證 |
| 適合場景 | 已支援裝置、Macro/Linked Games 等官方模組、第一方支援 | 本地控制、協議透明、未支援裝置實驗、社群持續維護 |
| 支援預期 | 官方 Razer 支援路徑 | 社群 best-effort 支援，並明確記錄限制 |

## 目前狀態

- `RazerMacOS` 內已有原生 SwiftUI/AppKit app shell
- macOS menu-bar 常駐狀態項
- 原生 Settings 視窗，支援透過 `ServiceManagement` 註冊 Launch at Login，並提供 macOS Login Items 捷徑
- 原生介面支援英文、簡體中文、繁體中文語言選擇
- 原生 DPI 與回報率控制
- bridge 可以從硬體讀到時顯示電池/狀態
- Swift 到 `librazermacos` 的 C bridge
- 原生 release 打包腳本，可產生 universal Developer ID 簽名 zip/dmg artifacts
- GitHub Actions workflow，可產生已簽名、已公證的 GitHub Releases
- `src/devices` 裝置目錄已更新，目前有 268 個裝置 JSON profile
- legacy Electron app 保留為參考實作與 fallback

## 相容裝置與功能

此倉庫有兩層支援：

- legacy Electron app 保留原 razer-macos/OpenRazer 工作的廣泛裝置目錄。`src/devices` 目前有 268 個裝置 JSON profile，legacy UI 仍保留歷史的顏色、亮度、狀態、鍵盤、滑鼠、滑鼠墊、dock、eGPU、耳機、手掣與筆電相關邏輯。
- 原生 app 的硬體驗證標準較嚴格。只有 SwiftUI/AppKit 介面、C bridge、macOS 硬體行為都已接好並測過的裝置，才會列入原生已驗證清單。DeathAdder V3 Pro 是第一個原生已驗證控制目標；這不是完整原生支援矩陣，也不代表專案只支援一款滑鼠。

完整相容性矩陣：

- [English compatibility matrix](docs/compatibility.md)
- [繁體中文相容性矩陣](docs/compatibility.zh-Hant.md)
- [简体中文兼容性矩阵](docs/compatibility.zh-Hans.md)

原生已驗證控制目標：

| 裝置 | Product ID | 原生控制 |
| --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | 偵測、DPI、回報率、電池/狀態 |

原生手掣目標：

| 裝置 | Product ID | 原生狀態 |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/接收器偵測，以及經 USB 直接讀取的即時輸入（XInput，自動識別 Xbox 360 / Xbox One GIP 協定，映射移植自 Linux xpad，待實機驗證）；震動和 LED 走輸出報告。Razer 私有設定檔/按鍵映射仍需協定擷取。 |

legacy 目錄覆蓋：

| 裝置類別 | 數量 | 目錄功能類型 |
| --- | ---: | --- |
| 滑鼠 | 113 | 固定顏色、光譜/呼吸/反應式效果、滑鼠亮度、DPI、回報率、電池 |
| 鍵盤 | 119 | 固定顏色、波浪/光譜/反應式/呼吸/星光/漣漪/色輪效果、亮度 |
| 滑鼠墊 | 8 | 固定顏色、波浪/光譜/呼吸效果、亮度 |
| 滑鼠充電座 | 2 | 固定顏色、光譜/呼吸效果、電池 |
| 配件 | 15 | 固定顏色、擴展波浪、光譜/呼吸效果 |
| 耳機 | 8 | 固定顏色、光譜/呼吸效果 |
| eGPU 外接盒 | 2 | 固定顏色、波浪/光譜/呼吸效果 |
| 手掣 | 1 | USB 偵測及 macOS Game Controller 即時輸入；電量、震動及燈光按系統能力啟用 |

目錄使用的功能 key 包括：`static`、`spectrum`、`breathe`、`reactive`、`starlight`、`ripple`、`wheel`、`brightness`、`mouseBrightness`、`dpi`、`pollRate`、`battery`。每款裝置的完整功能列表請看完整相容性矩陣。

## 已知硬體限制

在目前測試機器上，原生 bridge 與 legacy Node addon 都可以透過 `librazermacos` 偵測 DeathAdder V3 Pro。

原生硬體掃描輸出：

```text
productId=0x00B7 internalDeviceId=0 dpi=0 pollingRate=0
count=1
```

裝置可以被偵測，但此硬體路徑的 DPI、回報率與電池讀回命令仍可能逾時。原生 UI 會在讀回為 `0` 時使用安全預設值，明確顯示設定讀回逾時，並只把寫入命令標示為已透過 bridge 送出。

## 原生 app

建置並開啟原生 app：

```sh
./script/build_and_run.sh
```

建置、開啟並驗證 app process 啟動：

```sh
./script/build_and_run.sh --verify
```

透過原生 C bridge 掃描已連接的 Razer 滑鼠：

```sh
./script/build_and_run.sh --scan-hardware
```

執行 Swift 測試：

```sh
swift test --package-path RazerMacOS
```

原生 app 在主視窗關閉後仍會保持執行。可由 menu-bar 項目、Dock 或 Razer command menu 重新開啟。Launch at Login 與語言選擇可在原生 Settings 視窗中設定。

## Release 打包

建立本地原生 release artifacts：

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=auto ./script/package_native.sh
```

如果要產生 Developer ID 簽名的本地套件，請先確認登入鑰匙圈裡已安裝 `Developer ID Application` 身份，然後執行：

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=required ./script/package_native.sh
```

腳本會輸出：

- `dist/release/RazerMacOS-<version>-macOS.zip`
- `dist/release/RazerMacOS-<version>-macOS.dmg`
- `dist/release/SHA256SUMS.txt`

預設 release 打包會建置 `arm64` + `x86_64` universal binary。只有製作本地診斷套件時才建議覆蓋 `NATIVE_MACOS_ARCHS`。

`.dmg` 內會包含 `Razer macOS.app`、`Applications` 捷徑，以及提示使用者把 app 拖到 Applications 的 Finder 背景圖。

Ad-hoc 套件只適合本地測試：

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=adhoc ./script/package_native.sh
```

公開下載版本應使用 Developer ID 簽名並完成 Apple 公證。推送 `v*` tag，或手動執行 `Razer macOS Release` workflow 時，`.github/workflows/native-release.yml` 會建置 GitHub Release。

需要設定的倉庫 secrets：

| Secret | 用途 |
| --- | --- |
| `MACOS_CERTIFICATE_P12_BASE64` | Developer ID Application `.p12` 的 base64 內容 |
| `MACOS_CERTIFICATE_PASSWORD` | `.p12` 檔案密碼 |
| `MACOS_CODESIGN_IDENTITY` | 當 keychain 內有多個 Developer ID 身份時，用於明確指定簽名身份 |
| `APPLE_API_KEY_BASE64` | 用於公證的 App Store Connect API key `.p8` 的 base64 內容 |
| `APPLE_API_KEY_ID` | App Store Connect API key id |
| `APPLE_API_ISSUER_ID` | App Store Connect issuer id |

secrets 設定完成後，可用命令列發佈：

```sh
git tag v0.4.16
git push fork v0.4.16
```

也可以在 GitHub Actions 內用 workflow dispatch，輸入 `version=0.4.16`。workflow 會執行 Swift 測試、簽名原生 app 與 disk image、提交 Apple 公證、staple app 與 disk image、上傳建置 artifacts，並發佈 GitHub Release assets。

## Legacy Electron app

原 Electron app 會保留在倉庫中，直到原生 app 逐項補齊功能。它仍提供歷史 menu-bar UI、顏色效果、狀態管理與更廣的裝置覆蓋。在其他裝置類別完成原生移植並於 macOS 上驗證前，它仍是相容性參考。

安裝 Node 依賴：

```sh
yarn
```

執行 Electron 開發 app：

```sh
yarn dev
```

修改驅動後重建原生 Node addon：

```sh
yarn rebuild
```

編譯 Electron app：

```sh
yarn compile
```

建立發行套件：

```sh
yarn dist
```

## 架構

此倉庫目前有兩層 app，共用同一套驅動 lineage：

- `RazerMacOS/` 包含新的 SwiftUI/AppKit macOS app。
- `RazerMacOS/Sources/NativeRazerBridgeC/` 將 C 驅動函式暴露給 Swift。
- `librazermacos/` 包含低階 Razer USB/HID protocol 實作。
- `src/` 包含 legacy Electron UI、state manager、menu-bar app 與 Node addon integration。
- `src/devices/` 包含由 OpenRazer 與原 razer-macos 工作匯入並維護的裝置 profile。

長期來看，SwiftUI/AppKit app 應成為主要 macOS UI，因為它更自然地貼合 menu-bar 行為、Launch at Login、簽名、公證與 IOKit/HID integration。

## 裝置支援政策

新裝置支援應以 OpenRazer 裝置定義為基礎，並在可能時以實體硬體驗證。對於手上沒有的裝置，倉庫可以先匯入 ID 與 capability metadata，但 UI 控制應保持保守，直到對應硬體路徑被測過。

其他裝置功能應按 capability 逐步由 legacy app 移植，而不是一次複製整個舊畫面：

1. 滑鼠控制：DPI、回報率、電池、充電，以及 receiver/wired pairing 路徑。
2. 燈光控制：固定顏色、光譜/循環效果、亮度區域與裝置特定效果限制。
3. 狀態管理：啟動/刷新狀態、menu-bar 裝置操作與持久化。
4. 鍵盤與配件控制：profile、layout、亮度與裝置特定功能 gate。
5. 發行打包：維護已簽名並公證的原生 app artifacts、hardened runtime 與清楚的 macOS 權限說明。

發行打包現在已透過 `script/package_native.sh` 與 `.github/workflows/native-release.yml` 接好。它不是缺少的裝置控制功能，也不是缺少的 Launch at Login 功能；使用 `./script/build_and_run.sh` 做本地開發不需要完成 packaging。

在 capability 尚未接上原生 C bridge 並用真實裝置驗證前，應記錄為 legacy-supported，而不是 native-supported。

DeathAdder V3 Pro 路徑下一個 driver-level 任務，是改善或替換 DPI、回報率與電池狀態讀回會逾時的命令。

## 安裝備註

面向使用者的安裝方式，是從 GitHub Releases 下載最新已簽名並公證的原生 `.dmg` 或 `.zip`。本地開發請用 `./script/build_and_run.sh` 從 source 執行。

legacy Electron packaging flow 仍保留在倉庫中作為參考，但原生 SwiftUI/AppKit app 是主要 release 目標。

## Credits

此專案基於以下工作：

- [1kc/razer-macos](https://github.com/1kc/razer-macos)
- [openrazer/openrazer](https://github.com/openrazer/openrazer)
- [osx-razer-blade](https://github.com/kprinssu/osx-razer-blade)
- [osx-razer-led](https://github.com/dylanparker/osx-razer-led)
