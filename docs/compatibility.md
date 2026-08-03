# Compatibility Matrix

[English](compatibility.md) | [繁體中文](compatibility.zh-Hant.md) | [简体中文](compatibility.zh-Hans.md)

[Back to README](../README.md)

This matrix is generated from the current `src/devices/*.json` catalog and the legacy Electron feature defaults in `src/main/feature/featurehelper.js`.

> Generated from 268 device JSON profiles.

## Support Boundary

- The legacy Electron app keeps the broad device catalog and historical feature model.
- The native SwiftUI/AppKit app is stricter: only hardware paths that are wired through the native C bridge and tested on macOS are listed as native verified.
- A listed legacy catalog feature means the configuration exists in this repository. It does not guarantee that every readback/write path works on every macOS version or every physical unit.

## Native Verified Target

| Device | Product ID | Native controls | Status |
| --- | --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | Discovery, DPI, polling rate, battery/status | Verified first target; readback can still time out on current hardware path |

## Native Game Controller Target

| Device | Product ID | Native status |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/receiver discovery plus live input read directly over USB (XInput; Xbox 360 / Xbox One GIP auto-detected, ported from Linux xpad). Rumble and LED via output reports. Pending hardware verification; Razer-specific settings still need protocol capture. |

## Legacy Catalog Summary

| Class | Devices |
| --- | --- |
| Mice | 113 |
| Keyboards | 119 |
| Mouse mats | 8 |
| Mouse docks | 2 |
| Accessories | 15 |
| Headphones | 8 |
| eGPU enclosures | 2 |
| Game controllers | 1 |

## Feature Legend

| Feature key | Meaning |
| --- | --- |
| `battery` | Battery |
| `breathe` | Breathing |
| `brightness` | Brightness |
| `dpi` | DPI |
| `mouseBrightness` | Mouse brightness |
| `none` | Off / no effect |
| `oldMouseEffects` | Legacy mouse effects |
| `pollRate` | Polling rate |
| `reactive` | Reactive |
| `ripple` | Ripple |
| `spectrum` | Spectrum cycle |
| `starlight` | Starlight |
| `static` | Static color |
| `waveExtended` | Extended wave |
| `waveSimple` | Simple wave |
| `wheel` | Wheel |

## Full Legacy Device Catalog

### Mice (113)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Abyssus | `0x0042` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Abyssus 1800 | `0x0020` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Abyssus 2000 | `0x005E` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Abyssus Elite DVA Edition | `0x006A` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Abyssus Essential | `0x006B` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Abyssus V2 | `0x005B` | Static color, Legacy mouse effects, Mouse brightness, Polling rate, DPI |
| Razer Atheris (Receiver) | `0x0062` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Basilisk | `0x0064` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk Essential | `0x0065` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk Mobile Receiver | `0x00d4` | Off / no effect, Static color, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk Mobile Wired | `0x00d3` | Off / no effect, Static color, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk Ultimate | `0x0086` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk Ultimate Receiver | `0x0088` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V2 | `0x0085` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 | `0x0099` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 35K | `0x00cb` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wired | `0x00d6` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 Pro 35K Phantom Green Edition Wireless | `0x00d7` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 Pro 35K Wired | `0x00cc` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 Pro 35K Wireless | `0x00cd` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 Pro Wired | `0x00aa` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 Pro Wireless | `0x00ab` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk V3 X HyperSpeed | `0x00b9` | Mouse brightness, Polling rate, DPI, Battery |
| Razer Basilisk X HyperSpeed | `0x0083` | Polling rate, DPI, Battery |
| Razer Cobra | `0x00a3` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI |
| Razer Cobra Pro Wired | `0x00af` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Cobra Pro Wireless | `0x00b0` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder 1800 | `0x0038` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer DeathAdder 2000 | `0x004f` | Off / no effect, Breathing, Mouse brightness, Polling rate, DPI |
| Razer DeathAdder 2013 | `0x0037` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer DeathAdder 3.5G | `0x0016` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer DeathAdder 3.5G Black | `0x0029` | Polling rate, DPI |
| Razer DeathAdder 3500 | `0x0054` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder Chroma | `0x0043` | Static color, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder Elite | `0x005C` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder Essential | `0x006E` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder Essential (2021) | `0x0098` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder Essential (White Edition) | `0x0071` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder V2 | `0x0084` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder V2 Lite | `0x00a1` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI |
| Razer DeathAdder V2 Mini | `0x008C` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder V2 Pro Wired | `0x007C` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder V2 Pro Wireless | `0x007D` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer DeathAdder V2 X HyperSpeed | `0x009c` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 | `0x00b2` | Polling rate, DPI |
| Razer DeathAdder V3 HyperSpeed Wired | `0x00c4` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 HyperSpeed Wireless | `0x00c5` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 Pro Wired | `0x00b6` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 Pro Wired Alternate | `0x00c2` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 Pro Wireless | `0x00b7` | Polling rate, DPI, Battery |
| Razer DeathAdder V3 Pro Wireless Alternate | `0x00c3` | Polling rate, DPI, Battery |
| Razer DeathAdder V4 Pro Wired | `0x00be` | Polling rate, DPI, Battery |
| Razer DeathAdder V4 Pro Wireless | `0x00bf` | Polling rate, DPI, Battery |
| Razer Diamondback Chroma | `0x004C` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Hyper Polling Wireless Dongle | `0x00b3` | Polling rate, DPI, Battery |
| Razer Imperator | `0x002F` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Lancehead (Receiver) | `0x006F` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Lancehead Tournament Edition | `0x0060` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Lancehead Wired | `0x0059` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Lancehead Wireless | `0x005A` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Lancehead Wireless Wired | `0x0070` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Mamba (Receiver) | `0x0072` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Mamba 2012 Wired | `0x0024` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Mamba 2012 Wireless | `0x0025` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Mamba Elite | `0x006C` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI |
| Razer Mamba Tournament Edition | `0x0046` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Mamba Wired | `0x0044` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Mamba Wireless | `0x0045` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Mamba Wireless Wired | `0x0073` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga | `0x0015` | Off / no effect, Polling rate, DPI |
| Razer Naga 2012 | `0x002E` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Naga 2014 | `0x0040` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Naga Chroma | `0x0053` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Epic | `0x001f` | Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Epic Chroma Wired | `0x003e` | Off / no effect, Static color, Spectrum cycle, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Epic Chroma Wireless | `0x003f` | Off / no effect, Static color, Spectrum cycle, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Hex | `0x0041` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Naga Hex (Red) | `0x0036` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Naga Hex V2 | `0x0050` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Left Handed Edition 2020 | `0x008D` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Pro - Wired | `0x008f` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Pro - Wireless | `0x0090` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga Trinity | `0x0067` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga V2 HyperSpeed Receiver | `0x00b4` | Polling rate, DPI, Battery |
| Razer Naga V2 Pro Wired | `0x00a7` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga V2 Pro Wireless | `0x00a8` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Naga X | `0x0096` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Mouse brightness, Polling rate, DPI, Battery |
| Razer Orochi 2011 | `0x0013` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Orochi 2013 | `0x0039` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Orochi Chroma | `0x0048` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Orochi Chroma (Receiver) | `0x0094` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Orochi V2 (Bluetooth) | `0x0095` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Ouroboros | `0x0032` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Pro Click Mini Receiver | `0x009a` | Polling rate, DPI, Battery |
| Razer Pro Click Receiver | `0x0077` | Polling rate, DPI, Battery |
| Razer Pro Click V2 Vertical Edition Wired | `0x00c7` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Pro Click V2 Vertical Edition Wireless | `0x00c8` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Pro Click V2 Wired | `0x00d0` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Pro Click V2 Wireless | `0x00d1` | Off / no effect, Static color, Simple wave, Spectrum cycle, Mouse brightness, Polling rate, DPI, Battery |
| Razer Pro Click Wired | `0x0080` | Polling rate, DPI, Battery |
| Razer Taipan | `0x0034` | Off / no effect, Static color, Simple wave, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Polling rate, DPI, Battery |
| Razer Viper | `0x0078` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Viper 8Khz | `0x0091` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Viper Mini | `0x008A` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Viper Mini SE Wired | `0x009e` | Polling rate, DPI, Battery |
| Razer Viper Mini SE Wireless | `0x009f` | Polling rate, DPI, Battery |
| Razer Viper Ultimate Wired | `0x007A` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Viper Ultimate Wireless | `0x007B` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing, Legacy mouse effects, Mouse brightness, Polling rate, DPI, Battery |
| Razer Viper V2 Pro Wired | `0x00a5` | Polling rate, DPI, Battery |
| Razer Viper V2 Pro Wireless | `0x00a6` | Polling rate, DPI, Battery |
| Razer Viper V3 HyperSpeed | `0x00b8` | Polling rate, DPI, Battery |
| Razer Viper V3 Pro Wired | `0x00c0` | Polling rate, DPI, Battery |
| Razer Viper V3 Pro Wireless | `0x00c1` | Polling rate, DPI, Battery |

### Keyboards (119)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Anansi | `0x010F` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer BlackWidow 2019 | `0x0241` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Chroma | `0x0203` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Chroma Tournament Edition | `0x0209` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Chroma V2 | `0x0221` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Elite | `0x0228` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Essential | `0x0237` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Lite | `0x0235` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer BlackWidow Overwatch | `0x0211` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Stealth | `0x011B` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Stealth Edition | `0x010E` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Tournament Edition 2014 | `0x011c` |  |
| Razer BlackWidow Ultimate 2012 | `0x010D` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Ultimate 2013 | `0x011A` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow Ultimate 2016 | `0x0214` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V3 | `0x024e` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V3 Mini Hyperspeed (Wired) | `0x0258` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V3 Mini Hyperspeed (Wireless) | `0x0271` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V3 Pro (Wired) | `0x025A` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V3 Pro Wireless | `0x025c` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V3 Tenkeyless | `0x0a24` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V4 | `0x0287` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V4 75% | `0x02a5` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V4 Mini HyperSpeed Wired | `0x02b9` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V4 Mini HyperSpeed Wireless | `0x02ba` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V4 PRO | `0x028D` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wired | `0x02d7` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V4 Tenkeyless HyperSpeed Wireless | `0x02d5` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow V4 X | `0x0293` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer BlackWidow X Chroma | `0x0216` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow X Chroma Tournament Edition | `0x021A` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer BlackWidow X Ultimate | `0x0217` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade 14 2021 | `0x0270` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 14 2022 | `0x028c` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 14 2023 | `0x029d` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 14 2024 | `0x02b6` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 14 2025 | `0x02c5` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 15 (2018) | `0x0233` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade 15 (2018) Base Model | `0x023b` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Blade 15 (2019) Advanced | `0x023a` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade 15 (2019) Base Model | `0x0246` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Blade 15 (Mid 2019) Mercury White | `0x0245` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade 15 2023 | `0x029e` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 15 Advanced 2020 | `0x0253` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 15 Advanced 2021 | `0x0276` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 15 Advanced Early 2021 | `0x026d` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 15 Advanced Early 2022 | `0x028a` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 16 2023 | `0x029f` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 16 2025 | `0x02c6` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 17 2022 | `0x028b` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 17 Pro 2021 | `0x0279` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 17 Pro Early 2021 | `0x026e` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 18 2023 | `0x02a0` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 18 2024 | `0x02b8` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 18 2025 | `0x02c7` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade 2018 Mercury | `0x0240` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Advanced Late 2019 | `0x024b` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade Early 2020 Base | `0x0255` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Early 2021 Base | `0x026f` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Early 2022 Base | `0x027a` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Late 2016 | `0x0224` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Late 2020 Base | `0x0268` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Pro (2017) | `0x0225` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Pro 2017 FullHD | `0x022F` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Pro 2019 | `0x0234` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade Pro Early 2020 | `0x0256` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Ripple, Wheel |
| Razer Blade Pro Late 2016 | `0x0210` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Pro Late 2019 | `0x024c` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Blade Stealth | `0x0205` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Stealth (2019) | `0x0239` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Blade Stealth (Late 2016) | `0x0220` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Stealth (Late 2017) | `0x0232` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Stealth (Late 2019) | `0x024a` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Blade Stealth (Mid 2017) | `0x022D` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Stealth (QHD) | `0x020F` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Blade Stealth Early 2020 | `0x0252` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Stealth Late 2020 | `0x0259` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Blade Studio Edition 2019 | `0x024d` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Book 2020 | `0x026a` | Off / no effect, Static color, Spectrum cycle, Reactive, Breathing |
| Razer Cynosa Chroma | `0x022A` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Cynosa Chroma Pro | `0x022C` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Cynosa Lite | `0x023F` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Cynosa V2 | `0x025E` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Deathstalker Chroma | `0x0204` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer DeathStalker Essential | `0x0118` |  |
| Razer Deathstalker Expert | `0x0202` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Deathstalker V2 | `0x0295` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer DeathStalker V2 Pro TKL Wired | `0x0298` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer DeathStalker V2 Pro TKL Wireless | `0x0296` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer DeathStalker V2 Pro Wired | `0x0292` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer DeathStalker V2 Pro Wireless | `0x0290` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Huntsman | `0x0227` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman Elite | `0x0226` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman Mini | `0x0257` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman Mini (JP) | `0x0269` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman Mini Analog | `0x0282` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Ripple, Wheel |
| Razer Huntsman Tournament Edition | `0x0243` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman V2 | `0x026c` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman V2 Analog | `0x0266` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman V2 TKL | `0x026b` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Huntsman V3 Pro | `0x02a6` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Huntsman V3 Pro 8KHz | `0x02cf` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Huntsman V3 Pro Mini | `0x02b0` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Huntsman V3 Pro TKL | `0x02a7` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel |
| Razer Nostromo | `0x0111` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Orbweaver | `0x0113` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Orbweaver Chroma | `0x0207` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Ornata | `0x021F` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Ornata Chroma | `0x021E` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Ornata V2 | `0x025D` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |
| Razer Ornata V3 | `0x02a1` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing, Ripple, Wheel |
| Razer Ornata V3 Alternate | `0x028f` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing, Ripple, Wheel |
| Razer Ornata V3 Tenkeyless | `0x02a3` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Ripple, Wheel |
| Razer Ornata V3 X | `0x0294` | Off / no effect, Static color, Spectrum cycle, Breathing, Ripple, Wheel |
| Razer Ornata V3 X Alternate | `0x02a2` | Off / no effect, Static color, Spectrum cycle, Breathing, Ripple, Wheel |
| Razer Tartarus | `0x0201` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Tartarus Chroma | `0x0208` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness |
| Razer Tartarus Pro | `0x0244` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Brightness, Ripple, Wheel |
| Razer Tartarus V2 | `0x022B` | Off / no effect, Static color, Extended wave, Spectrum cycle, Reactive, Breathing, Starlight, Ripple, Wheel, Brightness |

### Mouse mats (8)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Firefly | `0x0C00` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing, Brightness |
| Razer Firefly Hyperflux | `0x0068` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing, Brightness |
| Razer Firefly V2 | `0x0c04` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing, Brightness |
| Razer Firefly V2 Pro | `0x0c08` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing |
| Razer Goliathus Chroma | `0x0C01` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing, Brightness |
| Razer Goliathus Chroma 3 XL | `0x0c06` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Goliathus Chroma Extended | `0x0C02` | Off / no effect, Static color, Spectrum cycle, Breathing, Brightness |
| Razer Strider Chroma | `0x0c05` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing |

### Mouse docks (2)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Mouse Charging Dock | `0x007E` | Off / no effect, Static color, Spectrum cycle, Breathing, Battery |
| Razer Mouse Dock Pro | `0x00a4` | Off / no effect, Static color, Spectrum cycle, Breathing |

### Accessories (15)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Base Station V2 Chroma | `0x0F20` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Charging Pad Chroma | `0x0f26` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Chroma ARGB | `0x0f1f` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Chroma Base | `0x0F08` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Chroma HDK | `0x0F09` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Chroma Mug | `0x0F07` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Laptop Stand Chroma | `0x0f0d` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Laptop Stand Chroma V2 | `0x0f2b` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Lian Li O11 Dynamic | `0x0f13` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Mouse Bungee V3 Chroma | `0x0F1D` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Nommo Chroma | `0x0517` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Nommo Pro | `0x0518` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Raptor 27 | `0x0f12` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Thunderbolt 4 Dock Chroma | `0x0F21` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |
| Razer Tomahawk ATX | `0x0f17` | Off / no effect, Static color, Extended wave, Spectrum cycle, Breathing |

### Game controllers (1)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0a3f` | Live buttons/axes read directly over USB via XInput (mapping ported from Linux xpad, pending hardware verification); rumble and LED via output reports. Vendor profile/remapping writes are not claimed. |

### Headphones (8)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Kraken 7.1 | `0x0501` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken 7.1 | `0x0506` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken 7.1 Chroma | `0x0504` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken Kitty Edition | `0x0F19` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken Kitty V2 | `0x0560` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken Tournament Edition | `0x0520` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken Ultimate | `0x0527` | Off / no effect, Static color, Spectrum cycle, Breathing |
| Razer Kraken V2 | `0x0510` | Off / no effect, Static color, Spectrum cycle, Breathing |

### eGPU enclosures (2)

| Device | Product ID | Catalog features |
| --- | --- | --- |
| Razer Core | `0x0215` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing |
| Razer Core X Chroma | `0x0f1a` | Off / no effect, Static color, Simple wave, Spectrum cycle, Breathing |

Source: `src/devices/*.json`; default feature sets come from `FeatureHelper.getDefaultFeaturesFor(mainType)`.
