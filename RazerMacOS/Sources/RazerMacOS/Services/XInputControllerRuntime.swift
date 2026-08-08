import Foundation
import NativeRazerBridgeC

struct XInputConnection: Equatable {
  static let protocol360 = 1
  static let protocolGip = 2

  let protocolCode: Int
}

enum XInputPollResult {
  case report(NativeRazerGamepadState)
  case timeout
  case error(Int32)
}

/// Direct XInput read path for Razer game controllers (Wolverine V3 Pro and
/// 8K variants), bypassing the GameController framework, which does not
/// expose third-party XInput devices on macOS.
///
/// `NativeRazerXInputPoll` blocks up to `timeoutMs`, so polling must run off
/// the main thread; the pure mapping helpers (`snapshot`, `isStale`, `nowMs`)
/// and the polling calls are `nonisolated` for that reason. Hardware calls
/// are not internally synchronized: the view model serializes poll/close on
/// its poll task, while rumble/LED writes run on a different pipe and may be
/// issued concurrently.
@MainActor
enum XInputControllerRuntime {
  nonisolated static let staleThresholdMs: UInt64 = 2_000
  static let ledPatternMax: UInt8 = 0x0A

  private static var currentLedPattern: UInt8 = 0

  /// Milliseconds on the same clock the C driver uses for `lastReportTimeMs`:
  /// `mach_absolute_time()` scaled by `mach_timebase_info`, see
  /// `monotonic_time_ms()` in razergamecontroller_driver.c.
  nonisolated private static let timebaseInfo: mach_timebase_info_data_t = {
    var info = mach_timebase_info_data_t()
    mach_timebase_info(&info)
    return info
  }()

  nonisolated static func nowMs() -> UInt64 {
    let info = timebaseInfo
    return mach_absolute_time() * UInt64(info.numer) / UInt64(info.denom) / 1_000_000
  }

  /// Opens the XInput interface. Returns nil when no supported controller is
  /// present or the interface cannot be claimed. Idempotent on the C side.
  static func connect() -> XInputConnection? {
    let code = Int(NativeRazerXInputOpen())
    guard code > 0 else {
      return nil
    }

    return XInputConnection(protocolCode: code)
  }

  nonisolated static func disconnect() {
    NativeRazerXInputClose()
  }

  nonisolated static func poll(timeoutMs: Int32) -> XInputPollResult {
    var state = NativeRazerGamepadState()
    let code = NativeRazerXInputPoll(&state, timeoutMs)
    if code == 1 {
      return .report(state)
    }
    if code == 0 {
      return .timeout
    }
    return .error(code)
  }

  /// Maps a raw report into the shared snapshot shape so the existing
  /// controller UI can render it. Buttons use Xbox naming; triggers are
  /// analog buttons (0...1, pressed above 0.1); sticks are normalized to
  /// -1...1. Battery is not part of the XInput report, so it stays nil.
  nonisolated static func snapshot(from state: NativeRazerGamepadState) -> GameControllerRuntimeSnapshot {
    var buttons: [GameControllerButtonSnapshot] = []

    func digital(_ bit: UInt16, _ name: String) {
      let pressed = state.buttons & bit != 0
      buttons.append(
        GameControllerButtonSnapshot(id: name, name: name, value: pressed ? 1 : 0, isPressed: pressed)
      )
    }

    digital(UInt16(NativeRazerGPButtonA), "A")
    digital(UInt16(NativeRazerGPButtonB), "B")
    digital(UInt16(NativeRazerGPButtonX), "X")
    digital(UInt16(NativeRazerGPButtonY), "Y")
    digital(UInt16(NativeRazerGPButtonLB), "Left Bumper")
    digital(UInt16(NativeRazerGPButtonRB), "Right Bumper")
    digital(UInt16(NativeRazerGPButtonView), "View")
    digital(UInt16(NativeRazerGPButtonMenu), "Menu")
    digital(UInt16(NativeRazerGPButtonGuide), "Guide")
    digital(UInt16(NativeRazerGPButtonL3), "Left Stick")
    digital(UInt16(NativeRazerGPButtonR3), "Right Stick")
    digital(UInt16(NativeRazerGPButtonDpadUp), "D-Pad Up")
    digital(UInt16(NativeRazerGPButtonDpadDown), "D-Pad Down")
    digital(UInt16(NativeRazerGPButtonDpadLeft), "D-Pad Left")
    digital(UInt16(NativeRazerGPButtonDpadRight), "D-Pad Right")

    func trigger(_ raw: UInt8, _ name: String) {
      let value = Float(raw) / 255.0
      buttons.append(
        GameControllerButtonSnapshot(id: name, name: name, value: value, isPressed: value > 0.1)
      )
    }

    trigger(state.leftTrigger, "Left Trigger")
    trigger(state.rightTrigger, "Right Trigger")

    func axis(_ raw: Int16) -> Float {
      min(1, max(-1, Float(raw) / 32767.0))
    }

    let pads = [
      GameControllerPadSnapshot(
        id: "Left Stick", name: "Left Stick", x: axis(state.leftX), y: axis(state.leftY)
      ),
      GameControllerPadSnapshot(
        id: "Right Stick", name: "Right Stick", x: axis(state.rightX), y: axis(state.rightY)
      ),
    ]

    return GameControllerRuntimeSnapshot(
      name: "Razer XInput Controller",
      productCategory: "XInput direct",
      buttons: buttons,
      pads: pads,
      batteryLevel: nil,
      isCharging: nil,
      hasHaptics: true,
      hasLight: true,
      hasRemappedElements: false
    )
  }

  /// A state is stale when the last input report is older than the threshold
  /// (receiver present, controller possibly powered off). A never-updated
  /// state (lastReportTimeMs == 0) is stale as well.
  nonisolated static func isStale(_ state: NativeRazerGamepadState, nowMs: UInt64) -> Bool {
    guard nowMs >= state.lastReportTimeMs else {
      return false
    }
    return nowMs - state.lastReportTimeMs > staleThresholdMs
  }

  /// Plays a short rumble pulse on both motors, then stops.
  static func rumbleTest() {
    Task.detached {
      _ = NativeRazerXInputRumble(0x80, 0x80)
      try? await Task.sleep(for: .milliseconds(300))
      _ = NativeRazerXInputRumble(0, 0)
    }
  }

  /// Cycles the controller LED through the preset patterns 0x00...0x0A and
  /// returns the pattern that was applied.
  @discardableResult
  static func ledNext() -> Int {
    currentLedPattern = currentLedPattern >= ledPatternMax ? 0 : currentLedPattern + 1
    _ = NativeRazerXInputLed(currentLedPattern)
    return Int(currentLedPattern)
  }
}
