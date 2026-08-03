import NativeRazerBridgeC
import Testing
@testable import RazerMacOS

struct XInputControllerRuntimeTests {
  @Test func snapshot_whenMappingState_usesXboxNamesAndAnalogValues() {
    var state = NativeRazerGamepadState()
    state.buttons = UInt16(NativeRazerGPButtonA) | UInt16(NativeRazerGPButtonGuide)
    state.leftTrigger = 128
    state.rightTrigger = 0
    state.leftX = 32767
    state.leftY = -32768
    state.rightX = 100
    state.rightY = -100

    let snapshot = XInputControllerRuntime.snapshot(from: state)

    #expect(snapshot.productCategory == "XInput direct")
    #expect(snapshot.hasHaptics)
    #expect(snapshot.hasLight)
    #expect(snapshot.batteryLevel == nil)
    #expect(snapshot.isCharging == nil)
    #expect(!snapshot.hasRemappedElements)
    #expect(snapshot.pads.count == 2)

    #expect(
      snapshot.buttons.map(\.name) == [
        "A", "B", "X", "Y",
        "Left Bumper", "Right Bumper",
        "View", "Menu", "Guide",
        "Left Stick", "Right Stick",
        "D-Pad Up", "D-Pad Down", "D-Pad Left", "D-Pad Right",
        "Left Trigger", "Right Trigger",
      ]
    )

    let buttonA = snapshot.buttons.first { $0.name == "A" }
    #expect(buttonA?.isPressed == true)
    #expect(buttonA?.value == 1)

    let buttonB = snapshot.buttons.first { $0.name == "B" }
    #expect(buttonB?.isPressed == false)
    #expect(buttonB?.value == 0)

    let guide = snapshot.buttons.first { $0.name == "Guide" }
    #expect(guide?.isPressed == true)

    let leftTrigger = snapshot.buttons.first { $0.name == "Left Trigger" }
    #expect(leftTrigger?.isPressed == true)
    #expect(abs((leftTrigger?.value ?? 0) - Float(128) / 255.0) < 0.001)

    let rightTrigger = snapshot.buttons.first { $0.name == "Right Trigger" }
    #expect(rightTrigger?.isPressed == false)
    #expect(rightTrigger?.value == 0)

    let leftPad = snapshot.pads.first { $0.name == "Left Stick" }
    #expect(leftPad?.x == 1)
    #expect(leftPad?.y == -1)

    let rightPad = snapshot.pads.first { $0.name == "Right Stick" }
    #expect(abs((rightPad?.x ?? 0) - Float(100) / 32767.0) < 0.001)
    #expect(abs((rightPad?.y ?? 0) - Float(-100) / 32767.0) < 0.001)
  }

  @Test func snapshot_whenTriggerIsBelowThreshold_isNotPressed() {
    var state = NativeRazerGamepadState()
    state.leftTrigger = 20  // 20/255 ≈ 0.08, below the 0.1 press threshold
    state.rightTrigger = 30  // 30/255 ≈ 0.12, above it

    let snapshot = XInputControllerRuntime.snapshot(from: state)

    #expect(snapshot.buttons.first { $0.name == "Left Trigger" }?.isPressed == false)
    #expect(snapshot.buttons.first { $0.name == "Right Trigger" }?.isPressed == true)
  }

  @Test func isStale_aroundThreshold_flipsOnlyPastTwoSeconds() {
    var state = NativeRazerGamepadState()
    state.lastReportTimeMs = 1_000

    #expect(!XInputControllerRuntime.isStale(state, nowMs: 2_999))
    #expect(!XInputControllerRuntime.isStale(state, nowMs: 3_000))
    #expect(XInputControllerRuntime.isStale(state, nowMs: 3_001))
  }

  @Test func isStale_withoutAnyReport_isStale() {
    let state = NativeRazerGamepadState()

    #expect(XInputControllerRuntime.isStale(state, nowMs: 10_000))
  }

  @Test func isStale_whenClockReadsEarlierThanReport_isNotStale() {
    var state = NativeRazerGamepadState()
    state.lastReportTimeMs = 5_000

    #expect(!XInputControllerRuntime.isStale(state, nowMs: 4_000))
  }
}
