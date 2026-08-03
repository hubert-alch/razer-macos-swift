import NativeRazerBridgeC
import Testing

struct NativeRazerBridgeControllerTests {
  @Test func gameControllerProductId_whenWolverineV3Pro_returnsSupported() {
    #expect(NativeRazerIsGameControllerProductId(0x0A3F) == 1)
  }

  @Test func gameControllerProductId_whenWolverineV3Pro8KVariants_returnsSupported() {
    #expect(NativeRazerIsGameControllerProductId(0x0A57) == 1)
    #expect(NativeRazerIsGameControllerProductId(0x0A59) == 1)
  }

  @Test func gameControllerProductId_whenUnknownRazerDevice_returnsUnsupported() {
    #expect(NativeRazerIsGameControllerProductId(0xFFFF) == 0)
  }

  @Test func parse360_withInputReport_mapsButtonsAndAxes() {
    // Layout per xpad360_process_packet in Linux xpad.c.
    var report = [UInt8](repeating: 0, count: 20)
    report[2] = 0x11  // DPadUp (bit0) + Menu (bit4)
    report[3] = 0x11  // LB (bit0) + A (bit4)
    report[4] = 128  // LT
    report[6] = 0x00; report[7] = 0x80  // leftX raw -32768
    report[8] = 0xFF; report[9] = 0x7F  // leftY raw 32767 -> ~ = -32768
    report[10] = 0x64; report[11] = 0x00  // rightX raw 100
    report[12] = 0x9C; report[13] = 0xFF  // rightY raw -100 -> ~ = 99

    var state = NativeRazerGamepadState()
    report.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParse360(buffer.baseAddress, Int32(report.count), &state)
    }

    #expect(state.buttons & UInt16(NativeRazerGPButtonA) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonLB) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonMenu) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonDpadUp) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonB) == 0)
    #expect(state.leftTrigger == 128)
    #expect(state.rightTrigger == 0)
    #expect(state.leftX == -32768)
    #expect(state.leftY == -32768)
    #expect(state.rightX == 100)
    #expect(state.rightY == 99)
  }

  @Test func parse360_withInvalidPacket_leavesStateUnchanged() {
    var report = [UInt8](repeating: 0, count: 20)
    report[0] = 0x01  // data[0] must be 0x00 for a valid input packet
    report[3] = 0x10

    var state = NativeRazerGamepadState()
    state.buttons = 42
    report.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParse360(buffer.baseAddress, Int32(report.count), &state)
    }

    #expect(state.buttons == 42)
    #expect(state.leftTrigger == 0)
    #expect(state.leftX == 0)
  }

  @Test func parseGip_withInputReport_mapsButtonsAndAxes() {
    // Layout per xpadone_process_packet in Linux xpad.c.
    var report = [UInt8](repeating: 0, count: 18)
    report[0] = 0x20  // GIP_CMD_INPUT
    report[4] = 0x14  // Menu (bit2) + A (bit4)
    report[5] = 0x11  // DPadUp (bit0) + LB (bit4)
    report[6] = 0xFF; report[7] = 0x03  // LT raw 1023 -> 255
    report[8] = 0x80; report[9] = 0x00  // RT raw 128 -> 32
    report[10] = 0x00; report[11] = 0x80  // leftX raw -32768
    report[12] = 0xFF; report[13] = 0x7F  // leftY raw 32767 -> ~ = -32768
    report[14] = 0x64; report[15] = 0x00  // rightX raw 100
    report[16] = 0x9C; report[17] = 0xFF  // rightY raw -100 -> ~ = 99

    var state = NativeRazerGamepadState()
    report.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(report.count), &state)
    }

    #expect(state.buttons & UInt16(NativeRazerGPButtonA) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonMenu) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonLB) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonDpadUp) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonGuide) == 0)
    #expect(state.leftTrigger == 255)
    #expect(state.rightTrigger == 32)
    #expect(state.leftX == -32768)
    #expect(state.leftY == -32768)
    #expect(state.rightX == 100)
    #expect(state.rightY == 99)
  }

  @Test func parseGip_withVirtualKeyReport_updatesOnlyGuide() {
    var input = [UInt8](repeating: 0, count: 18)
    input[0] = 0x20  // GIP_CMD_INPUT
    input[4] = 0x10  // A
    input[6] = 0xFF; input[7] = 0x03  // LT full

    var state = NativeRazerGamepadState()
    input.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(input.count), &state)
    }
    #expect(state.buttons & UInt16(NativeRazerGPButtonA) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonGuide) == 0)

    var virtualKey = [UInt8](repeating: 0, count: 5)
    virtualKey[0] = 0x07  // GIP_CMD_VIRTUAL_KEY
    virtualKey[4] = 0x01  // Guide pressed
    virtualKey.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(virtualKey.count), &state)
    }
    #expect(state.buttons & UInt16(NativeRazerGPButtonGuide) != 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonA) != 0)  // preserved
    #expect(state.leftTrigger == 255)  // preserved

    // Guide stays set across regular input reports.
    input.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(input.count), &state)
    }
    #expect(state.buttons & UInt16(NativeRazerGPButtonGuide) != 0)

    virtualKey[4] = 0x00  // Guide released
    virtualKey.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(virtualKey.count), &state)
    }
    #expect(state.buttons & UInt16(NativeRazerGPButtonGuide) == 0)
    #expect(state.buttons & UInt16(NativeRazerGPButtonA) != 0)
  }

  @Test func parseGip_withNonInputPacket_leavesStateUnchanged() {
    var report = [UInt8](repeating: 0, count: 18)
    report[0] = 0x02  // GIP_CMD_ANNOUNCE, not an input packet

    var state = NativeRazerGamepadState()
    state.buttons = 7
    report.withUnsafeBufferPointer { buffer in
      NativeRazerXInputParseGip(buffer.baseAddress, Int32(report.count), &state)
    }

    #expect(state.buttons == 7)
    #expect(state.leftTrigger == 0)
  }
}
