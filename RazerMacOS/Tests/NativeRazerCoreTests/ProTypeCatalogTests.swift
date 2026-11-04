import Testing
@testable import NativeRazerCore

struct ProTypeCatalogTests {
  @Test(arguments: ["0x0249", "0x0277", "0x027B"])
  func officeKeyboard_hasOnlyWhiteBacklightControls(productId: String) throws {
    let device = try #require(MigrationInventory().devices.first { $0.productId == productId })
    #expect(device.kind == .keyboard)
    #expect(device.capabilities == [.discovery, .lighting, .battery])
    #expect(device.controlConfiguration.monochromeLighting)
    #expect(!device.controlConfiguration.supportsStaticColor)
    #expect(device.controlConfiguration.lightingModes == [.none, .staticColor, .breathe])
    #expect(device.controlConfiguration.brightnessZones == [.all])
    #expect(device.controlConfiguration.dpi == nil)
    #expect(device.controlConfiguration.pollingRates.isEmpty)
  }
}
