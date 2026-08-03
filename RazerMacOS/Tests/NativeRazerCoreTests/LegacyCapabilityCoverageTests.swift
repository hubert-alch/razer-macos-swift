import Testing
@testable import NativeRazerCore

struct LegacyCapabilityCoverageTests {
  @Test func migrationInventory_whenLoaded_coversLegacyDeviceCatalog() {
    let inventory = MigrationInventory()

    #expect(inventory.devices.count >= 200)
    #expect(inventory.devices.contains { device in
      device.name.contains("Huntsman") && device.capabilities.contains(.lighting)
    })
    #expect(inventory.devices.contains { device in
      device.name.contains("Viper V3 Pro") && device.capabilities.contains(.dpi)
    })
  }

  @Test func deathAdderV3ProWireless_whenLoaded_doesNotExposeLightingControls() throws {
    let inventory = MigrationInventory()
    let device = try #require(inventory.devices.first { device in
      device.productId == "0x00B7"
    })

    #expect(device.capabilities.contains(.dpi))
    #expect(device.capabilities.contains(.pollingRate))
    #expect(device.capabilities.contains(.battery))
    #expect(!device.capabilities.contains(.lighting))
    #expect(!device.controlConfiguration.supportsLighting)
  }

  @Test func wolverineV3Pro_whenLoaded_hasSystemControllerSurfaceWithoutVendorConfiguration() throws {
    let inventory = MigrationInventory()
    let device = try #require(inventory.devices.first { device in
      device.productId == "0x0A3F"
    })

    #expect(device.name == "Razer Wolverine V3 Pro")
    #expect(device.kind == .gameController)
    #expect(device.capabilities == [.discovery])
    #expect(device.controlConfiguration == .none)
  }

  @Test func lightingMode_whenLoaded_coversLegacyLightingEffects() {
    let modeNames = Set(LightingMode.allCases.map(\.rawValue))

    #expect(modeNames.isSuperset(of: [
      "None",
      "Static",
      "Spectrum",
      "Breathe",
      "Reactive",
      "Starlight",
      "Wave",
      "Ripple",
      "Wheel"
    ]))
  }
}
