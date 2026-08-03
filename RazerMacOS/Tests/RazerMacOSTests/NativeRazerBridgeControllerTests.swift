import NativeRazerBridgeC
import Testing

struct NativeRazerBridgeControllerTests {
  @Test func gameControllerProductId_whenWolverineV3Pro_returnsSupported() {
    #expect(NativeRazerIsGameControllerProductId(0x0A3F) == 1)
  }

  @Test func gameControllerProductId_whenUnknownRazerDevice_returnsUnsupported() {
    #expect(NativeRazerIsGameControllerProductId(0xFFFF) == 0)
  }
}
