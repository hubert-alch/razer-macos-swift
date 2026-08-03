import Testing
@testable import NativeRazerCore
@testable import RazerMacOS

struct NativeDeviceStoreHardwareTests {
  @Test func refresh_whenKeyboardHardwareMatchesLegacyCatalog_marksDeviceConnected() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 77,
          productId: "0x0204",
          kind: .keyboard
        )
      ]
    )

    let store = NativeDeviceStore(hardwareController: hardware)
    let device = try #require(store.devices.first { device in
      device.productId == "0x0204"
    })

    #expect(device.name == "Razer Deathstalker Chroma")
    #expect(device.hardwareInternalId == 77)
    #expect(device.bridgeStatusMessage == .connected)
    #expect(device.controlConfiguration.supportsLighting)
  }

  @Test func refresh_whenGameControllerHardwareMatchesCatalog_marksConnected() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 88,
          productId: "0x0A3F",
          kind: .gameController
        )
      ]
    )

    let store = NativeDeviceStore(hardwareController: hardware)
    let device = try #require(store.devices.first { device in
      device.productId == "0x0A3F"
    })

    #expect(device.hardwareInternalId == 88)
    #expect(device.kind == .gameController)
    #expect(device.bridgeStatusMessage == .connected)
  }

  @Test func hardwareController_whenSettingLightingOrBrightness_returnsPreviewOnly() {
    let controller = NativeRazerHardwareController()

    #expect(
      controller.setLightingMode(
        .staticColor,
        color: RazerColor(red: 0, green: 255, blue: 0),
        kind: .keyboard,
        internalDeviceId: 77
      ) == .previewOnly(.lightingPreviewOnly)
    )
    #expect(
      controller.setBrightness(
        80,
        zone: .all,
        kind: .keyboard,
        internalDeviceId: 77
      ) == .previewOnly(.lightingPreviewOnly)
    )
  }

  @Test func store_whenLightingPreviewIsApplied_updatesPreviewStateWithoutHardwareSuccess() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 77,
          productId: "0x0204",
          kind: .keyboard
        )
      ],
      lightingResult: .previewOnly(.lightingPreviewOnly)
    )
    let store = NativeDeviceStore(hardwareController: hardware)
    let device = try #require(store.devices.first { device in
      device.productId == "0x0204"
    })
    store.selectedDeviceId = device.id

    store.setLightingMode(.wave)

    let updatedDevice = try #require(store.selectedDevice)
    #expect(hardware.lightingCalls == 1)
    #expect(updatedDevice.controlState.activeMode == .wave)
    #expect(updatedDevice.bridgeStatusMessage == .lightingPreviewOnly)
    #expect(store.lastRefreshSummary == .previewed(action: "Wave"))
  }

  @Test func sidebarSections_whenDevicesAreMixed_splitsConnectedFromSupportedOnly() {
    let connectedMouse = NativeDevice(
      id: "connected-mouse",
      name: "Razer DeathAdder V3 Pro",
      productId: "0x00B7",
      kind: .mouse,
      connection: "librazermacos internal #0",
      capabilities: [.discovery, .dpi],
      bridgeStatus: "Connected",
      hardwareInternalId: 0
    )
    let supportedKeyboard = NativeDevice(
      id: "supported-keyboard",
      name: "Razer Deathstalker Chroma",
      productId: "0x0204",
      kind: .keyboard,
      connection: "USB / receiver",
      capabilities: [.discovery, .lighting],
      bridgeStatus: "Legacy profile"
    )

    let sections = DeviceSidebarSections(
      devices: [supportedKeyboard, connectedMouse],
      searchText: ""
    )

    #expect(sections.connectedDevices.map(\.id) == ["connected-mouse"])
    #expect(sections.supportedDevices.map(\.id) == ["supported-keyboard"])
  }

  @Test func sidebarSections_whenSearching_filtersBothDeviceGroups() {
    let connectedMouse = NativeDevice(
      id: "connected-mouse",
      name: "Razer DeathAdder V3 Pro",
      productId: "0x00B7",
      kind: .mouse,
      connection: "librazermacos internal #0",
      capabilities: [.discovery, .dpi],
      bridgeStatus: "Connected",
      hardwareInternalId: 0
    )
    let supportedKeyboard = NativeDevice(
      id: "supported-keyboard",
      name: "Razer Deathstalker Chroma",
      productId: "0x0204",
      kind: .keyboard,
      connection: "USB / receiver",
      capabilities: [.discovery, .lighting],
      bridgeStatus: "Legacy profile"
    )

    let sections = DeviceSidebarSections(
      devices: [connectedMouse, supportedKeyboard],
      searchText: "0204"
    )

    #expect(sections.connectedDevices.isEmpty)
    #expect(sections.supportedDevices.map(\.id) == ["supported-keyboard"])
  }

  @Test func statusBarDevices_whenDisconnectedDeviceIsSelected_returnsOnlyConnectedHardware() throws {
    let hardware = FakeHardwareController(
      devices: [
        HardwareDeviceSnapshot(
          internalDeviceId: 7,
          productId: "0x00B7",
          kind: .mouse
        )
      ]
    )
    let store = NativeDeviceStore(hardwareController: hardware)
    let disconnectedDevice = try #require(store.devices.first { device in
      device.productId == "0x0204"
    })

    store.selectedDeviceId = disconnectedDevice.id

    #expect(store.selectedDevice?.productId == "0x0204")
    #expect(store.statusBarDevices.map(\.productId) == ["0x00B7"])
  }
}

private final class FakeHardwareController: NativeRazerHardwareControlling {
  let devices: [HardwareDeviceSnapshot]
  let mice: [HardwareMouseSnapshot]
  let lightingResult: HardwareApplyResult
  var lightingCalls = 0

  init(
    devices: [HardwareDeviceSnapshot] = [],
    mice: [HardwareMouseSnapshot] = [],
    lightingResult: HardwareApplyResult = .previewOnly(.lightingPreviewOnly)
  ) {
    self.devices = devices
    self.mice = mice
    self.lightingResult = lightingResult
  }

  func refreshDevices() -> [HardwareDeviceSnapshot] {
    devices
  }

  func refreshMice() -> [HardwareMouseSnapshot] {
    mice
  }

  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.hardwareNoConnectedMouse)
  }

  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.hardwareNoConnectedMouse)
  }

  func setLightingMode(
    _ mode: LightingMode,
    color: RazerColor,
    kind: NativeDeviceKind,
    internalDeviceId: Int?
  ) -> HardwareApplyResult {
    lightingCalls += 1
    return lightingResult
  }

  func setBrightness(
    _ brightness: Int,
    zone: BrightnessZone,
    kind: NativeDeviceKind,
    internalDeviceId: Int?
  ) -> HardwareApplyResult {
    .previewOnly(.lightingPreviewOnly)
  }

  func shutdown() {}
}
