# Pro Type / Pro Type Ultra protocol notes

Experimental macOS implementation, pending physical keyboard validation. USB only; Bluetooth and Fn-lock/macros are outside the implemented protocol.

| Model | VID:PID | HID control interface (wIndex) | Transaction ID |
| --- | --- | --- | --- |
| Pro Type | 1532:0249 | 0 | 0x1F |
| Pro Type Ultra Wired | 1532:0277 | 2 | 0x1F |
| Pro Type Ultra USB Receiver | 1532:027B | 2 | 0x9F |

Sources:

- [Pro Type USB captures](https://github.com/openrazer/openrazer/issues/1238), attached by mneilly on 2023-04-11: [capture archive](https://github.com/openrazer/openrazer/files/11197302/razer-pro-type-keyboard.zip). `razer-static.pcapng` and `razer-breathing.pcapng` contain SET_REPORT setup `21 09 00 03 00 00 5a 00`, followed by the 90-byte report. Static arguments: `01 05 01 00 01 01 ff ff ff`; breathing: `01 05 02 00 01 01 ff ff ff`. Brightness uses class/command `0f/04`, arguments `01 05 <0..255>`; captured 50% is `7f`. Off uses brightness zero. Battery and charging use `07/80` and `07/84`.
- [OpenRazer PR #2888](https://github.com/openrazer/openrazer/pull/2888), by iacoviola, remains an unmerged protocol reference. It supplies Ultra IDs, interface indices, transaction IDs and white-light argument 4 = 1. It reports Linux hardware testing, which does not establish macOS compatibility.

Only off, steady white and single-white breathing are exposed; requests always use white, independent of saved RGB settings. The native UI hides RGB selection. On the original Pro Type, off sets brightness to zero; raise brightness to illuminate again. Legacy lighting calls use the same protocol implementation. The native bridge returns success only for a complete, matching, checksummed successful response. Busy responses are polled at most three times; failed/short/stale responses leave battery unknown rather than reporting a false zero. A successful zero battery reading remains 0%.

Run transport tests (macOS, no keyboard required) from the repository root:

```sh
clang -Ilibrazermacos/src/include librazermacos/tests/protype_test.c librazermacos/src/lib/razerprotype_driver.c librazermacos/src/lib/razercommon.c librazermacos/src/lib/razerchromacommon.c -framework IOKit -framework CoreFoundation -o /tmp/razer-pro-type-test
/tmp/razer-pro-type-test
```

Before promoting these devices to hardware-verified support, test enumeration, off/steady/breathing, 0/50/100% brightness, battery/charging, wake and reconnect on each USB variant. Confirm ordinary typing remains usable and unrelated keyboards retain preview-only native lighting.
