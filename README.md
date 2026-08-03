# Razer macOS

[English](README.md) | [繁體中文](README.zh-Hant.md) | [简体中文](README.zh-Hans.md)

Razer macOS is an independent open-source macOS control app for Razer peripherals. It is now a native SwiftUI/AppKit app backed by the existing `librazermacos` IOKit/HID driver code, with the legacy Electron implementation retained only as a compatibility reference.

The current development focus is practical macOS support for newer Razer devices imported from OpenRazer, starting with the Razer DeathAdder V3 Pro.

## Why This Project Exists

Razer macOS exists because macOS Razer device support should have an open, inspectable path. Many Razer peripheral features are ultimately USB/HID protocol commands, and community projects such as OpenRazer and razer-macos have accumulated device metadata and behavior that users can study, fix, and extend. This project turns that work into a native macOS app that can be audited, packaged, and improved without depending on a closed device manager.

This project is not affiliated with Razer and is not trying to hide its current limits. Official Razer Synapse for Mac remains the right choice when your device is supported and you need first-party support, official modules, or warranty-oriented workflows. Razer macOS focuses on local device control, transparent compatibility data, OpenRazer-derived device work, and a lightweight macOS menu-bar experience that the community can keep improving.

## Difference from Official Razer Synapse for Mac

Razer now provides [Razer Synapse for Mac](https://mysupport.razer.com/app/answers/detail/a_id/15479/~/razer-synapse-for-mac-support-%26-faqs) for supported Apple silicon Macs running macOS Ventura 13 and above. Official device support is defined by Razer's [supported and compatible device list](https://mysupport.razer.com/app/answers/detail/a_id/14809/~/razer-synapse-for-mac-supported-and-compatible-devices), and unsupported or mismatched configurations may not detect devices or may restrict available functionality.

| Area | Official Razer Synapse for Mac | Razer macOS |
| --- | --- | --- |
| Ownership | First-party Razer software | Independent community project |
| Source model | Closed product software | Open-source app, bridge, and device metadata |
| Platform target | Apple silicon Macs on macOS Ventura 13+ | Universal `arm64` + `x86_64` native app, currently targeting macOS 14+ |
| Device strategy | Razer-curated supported device list | OpenRazer/legacy catalog plus native hardware verification |
| Best fit | Supported devices, official modules such as Macro and Linked Games, first-party support | Local controls, protocol transparency, unsupported-device experiments, community maintenance |
| Support expectation | Official Razer support path | Community best-effort support with documented limitations |

## Current Status

- Native SwiftUI/AppKit app shell in `RazerMacOS`
- macOS menu-bar resident app with a persistent status item
- Native settings window with Launch at Login support through `ServiceManagement` and a System Settings Login Items shortcut
- Native UI language selection for English, Simplified Chinese, and Traditional Chinese
- Native device controls for DPI and polling rate
- Battery/status display when the bridge can read it from hardware
- C bridge from Swift into `librazermacos`
- Native release packaging script for universal Developer ID signed zip/dmg artifacts
- GitHub Actions workflow for signed, notarized GitHub Releases
- Refreshed device catalog under `src/devices` with 268 device JSON profiles
- Legacy Electron app retained as a reference implementation and fallback

## Support Matrix

There are two support layers in this repository:

- Legacy Electron app keeps the broad device catalog from the original razer-macos/OpenRazer work. The `src/devices` directory currently contains 268 device JSON profiles, and the legacy UI still owns the historical color, brightness, state, keyboard, mouse, mouse mat, dock, eGPU, headphone, game-controller, and laptop logic.
- Native app verified hardware path is stricter. A device is listed here only when the SwiftUI/AppKit surface, C bridge, and macOS hardware behavior have been wired and tested. DeathAdder V3 Pro is the first verified native control target; this is not the full native support matrix and it does not mean the project supports only one mouse.

Full compatibility matrix:

- [English compatibility matrix](docs/compatibility.md)
- [繁體中文相容性矩陣](docs/compatibility.zh-Hant.md)
- [简体中文兼容性矩阵](docs/compatibility.zh-Hans.md)

Native verified control targets:

| Device | Product ID | Native controls |
| --- | --- | --- |
| Razer DeathAdder V3 Pro | `0x00B7` | Discovery, DPI, polling rate, battery/status |

Native game-controller targets:

| Device | Product ID | Native status |
| --- | --- | --- |
| Razer Wolverine V3 Pro | `0x0A3F` | USB/receiver discovery plus live macOS Game Controller inputs; battery, haptics, and light appear only when macOS exposes them. Razer-specific profiles/remapping still require protocol capture and hardware verification. |

Legacy catalog coverage:

| Device class | Count | Catalog feature families |
| --- | ---: | --- |
| Mice | 113 | Static color, spectrum/breathing/reactive effects, mouse brightness, DPI, polling rate, battery |
| Keyboards | 119 | Static color, wave/spectrum/reactive/breathing/starlight/ripple/wheel effects, brightness |
| Mouse mats | 8 | Static color, wave/spectrum/breathing effects, brightness |
| Mouse docks | 2 | Static color, spectrum/breathing effects, battery |
| Accessories | 15 | Static color, extended wave, spectrum/breathing effects |
| Headphones | 8 | Static color, spectrum/breathing effects |
| eGPU enclosures | 2 | Static color, wave/spectrum/breathing effects |
| Game controllers | 1 | USB discovery and macOS Game Controller live input; capability-gated battery, haptics, and light |

Feature keys used by the catalog: `static`, `spectrum`, `breathe`, `reactive`, `starlight`, `ripple`, `wheel`, `brightness`, `mouseBrightness`, `dpi`, `pollRate`, and `battery`. See the full matrix for the per-device feature list.

## Known Hardware Limitation

On the current test machine, the native bridge and the legacy Node addon both detect the DeathAdder V3 Pro through `librazermacos`.

The native hardware probe reports:

```text
productId=0x00B7 internalDeviceId=0 dpi=0 pollingRate=0
count=1
```

The device is detected, but DPI, polling-rate, and battery readback commands can still time out on this hardware path. The native UI therefore uses safe default values when readback returns `0`, clearly reports that settings readback timed out, and only reports write commands as sent through the bridge.

## Native App

Build and open the native app:

```sh
./script/build_and_run.sh
```

Build, open, and verify the app process starts:

```sh
./script/build_and_run.sh --verify
```

Scan connected Razer mice through the native C bridge:

```sh
./script/build_and_run.sh --scan-hardware
```

Run Swift tests:

```sh
swift test --package-path RazerMacOS
```

The native app keeps running after its main window is closed. Reopen it from the menu-bar item, Dock, or the Razer command menu. Launch at Login and language selection are available from the native Settings window.

## Release Packaging

Create local native release artifacts:

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=auto ./script/package_native.sh
```

For a Developer ID signed local package, make sure a `Developer ID Application` identity is installed in the login keychain, then run:

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=required ./script/package_native.sh
```

The script writes:

- `dist/release/RazerMacOS-<version>-macOS.zip`
- `dist/release/RazerMacOS-<version>-macOS.dmg`
- `dist/release/SHA256SUMS.txt`

By default, release packaging builds a universal `arm64` + `x86_64` binary. Override `NATIVE_MACOS_ARCHS` only when producing a local diagnostic build.

The `.dmg` contains `Razer macOS.app`, an `Applications` shortcut, and a Finder background that guides users to drag the app into Applications.

Ad-hoc packages are useful for local testing only:

```sh
APP_VERSION=0.4.16 MACOS_SIGNING_MODE=adhoc ./script/package_native.sh
```

Public downloads should be Developer ID signed and notarized. GitHub Releases are built by `.github/workflows/native-release.yml` when a `v*` tag is pushed or when the `Razer macOS Release` workflow is run manually.

Required repository secrets:

| Secret | Purpose |
| --- | --- |
| `MACOS_CERTIFICATE_P12_BASE64` | Base64-encoded Developer ID Application `.p12` |
| `MACOS_CERTIFICATE_PASSWORD` | Password for the `.p12` file |
| `MACOS_CODESIGN_IDENTITY` | Optional explicit signing identity when the keychain has more than one Developer ID identity |
| `APPLE_API_KEY_BASE64` | Base64-encoded App Store Connect API key `.p8` for notarization |
| `APPLE_API_KEY_ID` | App Store Connect API key id |
| `APPLE_API_ISSUER_ID` | App Store Connect issuer id |

Run a release from the command line after the secrets are configured:

```sh
git tag v0.4.16
git push fork v0.4.16
```

Or use GitHub Actions workflow dispatch with `version=0.4.16`. The workflow runs Swift tests, signs the native app and disk image, submits notarization, staples the app and disk image, uploads build artifacts, and publishes the GitHub Release assets.

## Legacy Electron App

The original Electron app remains in the repository while the native app catches up feature by feature. It still provides the historical menu-bar UI, color effects, state management, and broader device coverage. It is the compatibility reference for other device classes until the native app ports those controls and proves them on macOS.

Install Node dependencies:

```sh
yarn
```

Run the Electron development app:

```sh
yarn dev
```

Rebuild the native Node addon after driver changes:

```sh
yarn rebuild
```

Compile the Electron app:

```sh
yarn compile
```

Build a distribution package:

```sh
yarn dist
```

## Architecture

The repository currently has two application layers over the same driver lineage:

- `RazerMacOS/` contains the new SwiftUI/AppKit macOS app.
- `RazerMacOS/Sources/NativeRazerBridgeC/` exposes the C driver functions to Swift.
- `librazermacos/` contains the low-level Razer USB/HID protocol implementation.
- `src/` contains the legacy Electron UI, state manager, menu-bar app, and Node addon integration.
- `src/devices/` contains device profiles imported and maintained from OpenRazer and the previous razer-macos work.

Long-term, the SwiftUI/AppKit app should become the primary macOS UI because it fits menu-bar behavior, Launch at Login, signing, notarization, and IOKit/HID integration more naturally than Electron.

## Device Support Policy

New-device support should be grounded in OpenRazer device definitions, then verified on real hardware whenever possible. For devices not physically available, the repo can import identifiers and capability metadata, but UI controls should stay conservative until a matching hardware path is tested.

Other device functionality should be moved over from the legacy app by capability, not by copying every screen at once:

1. Mouse controls: DPI, polling rate, battery, charging, and receiver/wired pairing paths.
2. Lighting controls: static color, spectrum/cycle effects, brightness zones, and per-device effect constraints.
3. State management: startup/refresh states, menu-bar device actions, and persistence.
4. Keyboard and accessory controls: profile, layout, brightness, and device-specific feature gates.
5. Distribution packaging: maintain signed and notarized native app artifacts with hardened runtime and clear macOS permission copy.

Distribution packaging is now wired through `script/package_native.sh` and `.github/workflows/native-release.yml`. It is not a missing device-control feature, not a missing Launch at Login feature, and packaging is not required for local development with `./script/build_and_run.sh`.

Until a capability is connected through the native C bridge and verified against a real device, it should remain documented as legacy-supported rather than native-supported.

For the DeathAdder V3 Pro path, the next driver-level task is improving or replacing the timed-out settings readback commands for DPI, polling rate, and battery state.

## Installation Notes

End users should install the latest signed and notarized native `.dmg` or `.zip` from GitHub Releases once a release has been published. For local development, run from source with `./script/build_and_run.sh`.

The legacy Electron packaging flow remains in the repository for reference, but the native SwiftUI/AppKit app is the primary release target.

## Credits

This project builds on work from:

- [1kc/razer-macos](https://github.com/1kc/razer-macos)
- [openrazer/openrazer](https://github.com/openrazer/openrazer)
- [osx-razer-blade](https://github.com/kprinssu/osx-razer-blade)
- [osx-razer-led](https://github.com/dylanparker/osx-razer-led)
