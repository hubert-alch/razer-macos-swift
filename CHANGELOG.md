# 更新日志 / Changelog

## Unreleased — 2026-11-04

- 新增 Pro Type（`1532:0249`）、Pro Type Ultra 有线（`1532:0277`）及 USB 接收器（`1532:027B`）识别和设备配置。
- 接通实验性原生白色背光关闭、常亮、呼吸、亮度调节及电量／充电状态读取；隐藏不适用的 RGB 选色。底层检查响应长度、校验和、命令及执行状态，失败不报告成功。
- 同步英文、简体和繁体兼容说明。尚待 macOS 实机验证，不包含蓝牙控制、宏或 Fn 锁配置；初代 Pro Type 关灯后需调高亮度重新点亮。

- Added Pro Type and Pro Type Ultra wired / USB receiver profiles and USB discovery.
- Connected experimental native white-backlight off, steady, breathing, brightness and battery/charging reads; hid RGB selection for these monochrome keyboards. Protocol failures are reported rather than treated as successful writes.
- Updated all three compatibility documents. Physical macOS validation is pending. Bluetooth control, macros and Fn-lock configuration are not included. Raise brightness after turning off the original Pro Type.

Protocol sources and validation steps: [Pro Type protocol notes](docs/pro-type-protocol.md).
