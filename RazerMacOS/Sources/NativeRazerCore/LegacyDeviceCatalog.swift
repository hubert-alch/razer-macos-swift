// Generated from src/devices/*.json. Keep the source JSON as the authority for legacy profile data.

public enum LegacyFeatureKey: String, CaseIterable, Sendable {
  case none = "none"
  case staticLighting = "static"
  case waveSimple = "waveSimple"
  case waveExtended = "waveExtended"
  case spectrum = "spectrum"
  case reactive = "reactive"
  case breathe = "breathe"
  case starlight = "starlight"
  case brightness = "brightness"
  case ripple = "ripple"
  case wheel = "wheel"
  case oldMouseEffects = "oldMouseEffects"
  case mouseBrightness = "mouseBrightness"
  case pollRate = "pollRate"
  case dpi = "dpi"
  case battery = "battery"
}

public struct LegacyDeviceDefinition: Equatable, Sendable {
  public let id: String
  public let name: String
  public let productId: String
  public let kind: NativeDeviceKind
  public let featureKeys: [LegacyFeatureKey]
  public let dpiMax: Int?
  public let pollRates: [Int]
  public let brightnessZones: [BrightnessZone]

  public var nativeDevice: NativeDevice {
    NativeDevice(
      id: id,
      name: name,
      productId: productId,
      kind: kind,
      connection: defaultConnection,
      capabilities: capabilities,
      bridgeStatus: AppMessage.legacyProfileLoaded.localized(language: .english),
      bridgeStatusMessage: .legacyProfileLoaded,
      controlConfiguration: controlConfiguration,
      controlState: controlState
    )
  }

  private var defaultConnection: String {
    switch kind {
    case .mouse, .keyboard, .mouseDock, .mouseMat, .headphone, .accessory, .egpu, .gameController:
      "USB / receiver"
    case .unknown:
      "Legacy profile"
    }
  }

  private var capabilities: [DeviceCapability] {
    var values: [DeviceCapability] = [.discovery]
    if hasLighting { values.append(.lighting) }
    if featureKeys.contains(.dpi) { values.append(.dpi) }
    if featureKeys.contains(.pollRate) { values.append(.pollingRate) }
    if featureKeys.contains(.battery) { values.append(.battery) }
    return values
  }

  private var hasLighting: Bool {
    !lightingModes.isEmpty || !brightnessZones.isEmpty
  }

  private var controlConfiguration: DeviceControlConfiguration {
    DeviceControlConfiguration(
      dpi: featureKeys.contains(.dpi) ? DPIConfiguration(min: 100, max: dpiMax ?? 16_000, step: 100) : nil,
      pollingRates: featureKeys.contains(.pollRate) ? (pollRates.isEmpty ? [125, 250, 500, 1_000] : pollRates) : [],
      brightnessZones: brightnessZones,
      lightingModes: lightingModes
    )
  }

  private var controlState: DeviceControlState {
    DeviceControlState(
      dpi: featureKeys.contains(.dpi) ? 1_600 : nil,
      pollingRate: featureKeys.contains(.pollRate) ? 1_000 : nil,
      brightness: Dictionary(uniqueKeysWithValues: brightnessZones.map { ($0, 100) }),
      activeMode: lightingModes.first ?? .none
    )
  }

  private var lightingModes: [LightingMode] {
    let preferred: [(LegacyFeatureKey, LightingMode)] = [
      (.none, .none),
      (.staticLighting, .staticColor),
      (.spectrum, .spectrum),
      (.breathe, .breathe),
      (.reactive, .reactive),
      (.starlight, .starlight),
      (.waveSimple, .wave),
      (.waveExtended, .wave),
      (.ripple, .ripple),
      (.wheel, .wheel),
      (.oldMouseEffects, .oldMouseEffects)
    ]

    var seen = Set<LightingMode>()
    return preferred.compactMap { feature, mode in
      guard featureKeys.contains(feature), !seen.contains(mode) else { return nil }
      seen.insert(mode)
      return mode
    }
  }
}

public enum LegacyDeviceCatalog {
  public static let definitions: [LegacyDeviceDefinition] = [
    LegacyDeviceDefinition(
      id: "abyssus",
      name: "Razer Abyssus",
      productId: "0x0042",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "abyssus_1800",
      name: "Razer Abyssus 1800",
      productId: "0x0020",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 1800,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "abyssus_2000",
      name: "Razer Abyssus 2000",
      productId: "0x005E",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 2000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "abyssus_elite_dva_edition",
      name: "Razer Abyssus Elite DVA Edition",
      productId: "0x006A",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 7200,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "abyssus_essential",
      name: "Razer Abyssus Essential",
      productId: "0x006B",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 7200,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "abyssus_v2",
      name: "Razer Abyssus V2",
      productId: "0x005B",
      kind: .mouse,
      featureKeys: [.staticLighting, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 5000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "anansi",
      name: "Razer Anansi",
      productId: "0x010F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "atheris",
      name: "Razer Atheris (Receiver)",
      productId: "0x0062",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 7200,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "base_station_v2_chroma",
      name: "Razer Base Station V2 Chroma",
      productId: "0x0F20",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "basilisk",
      name: "Razer Basilisk",
      productId: "0x0064",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_essential",
      name: "Razer Basilisk Essential",
      productId: "0x0065",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_mobile_receiver",
      name: "Razer Basilisk Mobile Receiver",
      productId: "0x00D4",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_mobile_wired",
      name: "Razer Basilisk Mobile Wired",
      productId: "0x00D3",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_ultimate",
      name: "Razer Basilisk Ultimate",
      productId: "0x0086",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo, .scroll, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_ultimate_receiver",
      name: "Razer Basilisk Ultimate Receiver",
      productId: "0x0088",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo, .scroll, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v2",
      name: "Razer Basilisk V2",
      productId: "0x0085",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3",
      name: "Razer Basilisk V3",
      productId: "0x0099",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 26000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_35_k",
      name: "Razer Basilisk V3 35K",
      productId: "0x00CB",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro35_k_phantom_green_edition_wired",
      name: "Razer Basilisk V3 Pro 35K Phantom Green Edition Wired",
      productId: "0x00D6",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: [.matrix, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro35_k_phantom_green_edition_wireless",
      name: "Razer Basilisk V3 Pro 35K Phantom Green Edition Wireless",
      productId: "0x00D7",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: [.matrix, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro35_k_wired",
      name: "Razer Basilisk V3 Pro 35K Wired",
      productId: "0x00CC",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro35_k_wireless",
      name: "Razer Basilisk V3 Pro 35K Wireless",
      productId: "0x00CD",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro_wired",
      name: "Razer Basilisk V3 Pro Wired",
      productId: "0x00AA",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_pro_wireless",
      name: "Razer Basilisk V3 Pro Wireless",
      productId: "0x00AB",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_v3_x_hyper_speed",
      name: "Razer Basilisk V3 X HyperSpeed",
      productId: "0x00B9",
      kind: .mouse,
      featureKeys: [.mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: [.scroll]
    ),
    LegacyDeviceDefinition(
      id: "basilisk_x_hyper_speed",
      name: "Razer Basilisk X HyperSpeed",
      productId: "0x0083",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_tournament_edition2014",
      name: "Razer BlackWidow Tournament Edition 2014",
      productId: "0x011C",
      kind: .keyboard,
      featureKeys: [],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v3_pro_wireless",
      name: "Razer BlackWidow V3 Pro Wireless",
      productId: "0x025C",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4",
      name: "Razer BlackWidow V4",
      productId: "0x0287",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4_mini_hyper_speed_wired",
      name: "Razer BlackWidow V4 Mini HyperSpeed Wired",
      productId: "0x02B9",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4_mini_hyper_speed_wireless",
      name: "Razer BlackWidow V4 Mini HyperSpeed Wireless",
      productId: "0x02BA",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4_tenkeyless_hyper_speed_wired",
      name: "Razer BlackWidow V4 Tenkeyless HyperSpeed Wired",
      productId: "0x02D7",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4_tenkeyless_hyper_speed_wireless",
      name: "Razer BlackWidow V4 Tenkeyless HyperSpeed Wireless",
      productId: "0x02D5",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "black_widow_v4_x",
      name: "Razer BlackWidow V4 X",
      productId: "0x0293",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_2019",
      name: "Razer BlackWidow 2019",
      productId: "0x0241",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_chroma",
      name: "Razer BlackWidow Chroma",
      productId: "0x0203",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_chroma_te",
      name: "Razer BlackWidow Chroma Tournament Edition",
      productId: "0x0209",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_chroma_v2",
      name: "Razer BlackWidow Chroma V2",
      productId: "0x0221",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_elite",
      name: "Razer BlackWidow Elite",
      productId: "0x0228",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_essential",
      name: "Razer BlackWidow Essential",
      productId: "0x0237",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_lite",
      name: "Razer BlackWidow Lite",
      productId: "0x0235",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_overwatch",
      name: "Razer BlackWidow Overwatch",
      productId: "0x0211",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_stealth",
      name: "Razer BlackWidow Stealth",
      productId: "0x011B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_stealth_edition",
      name: "Razer BlackWidow Stealth Edition",
      productId: "0x010E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_ultimate_2012",
      name: "Razer BlackWidow Ultimate 2012",
      productId: "0x010D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_ultimate_2013",
      name: "Razer BlackWidow Ultimate 2013",
      productId: "0x011A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_ultimate_2016",
      name: "Razer BlackWidow Ultimate 2016",
      productId: "0x0214",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v3",
      name: "Razer BlackWidow V3",
      productId: "0x024E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v3_mini_wired",
      name: "Razer BlackWidow V3 Mini Hyperspeed (Wired)",
      productId: "0x0258",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v3_mini_wireless",
      name: "Razer BlackWidow V3 Mini Hyperspeed (Wireless)",
      productId: "0x0271",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v3_pro_wired",
      name: "Razer BlackWidow V3 Pro (Wired)",
      productId: "0x025A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v3_tk",
      name: "Razer BlackWidow V3 Tenkeyless",
      productId: "0x0A24",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v4_75%",
      name: "Razer BlackWidow V4 75%",
      productId: "0x02A5",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_v4_pro",
      name: "Razer BlackWidow V4 PRO",
      productId: "0x028D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_x_chroma",
      name: "Razer BlackWidow X Chroma",
      productId: "0x0216",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_x_chroma_te",
      name: "Razer BlackWidow X Chroma Tournament Edition",
      productId: "0x021A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blackwidow_x_ultimate",
      name: "Razer BlackWidow X Ultimate",
      productId: "0x0217",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade142021",
      name: "Razer Blade 14 2021",
      productId: "0x0270",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade142022",
      name: "Razer Blade 14 2022",
      productId: "0x028C",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade142023",
      name: "Razer Blade 14 2023",
      productId: "0x029D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade142024",
      name: "Razer Blade 14 2024",
      productId: "0x02B6",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade142025",
      name: "Razer Blade 14 2025",
      productId: "0x02C5",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade152023",
      name: "Razer Blade 15 2023",
      productId: "0x029E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade15_advanced2020",
      name: "Razer Blade 15 Advanced 2020",
      productId: "0x0253",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade15_advanced2021",
      name: "Razer Blade 15 Advanced 2021",
      productId: "0x0276",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade15_advanced_early2021",
      name: "Razer Blade 15 Advanced Early 2021",
      productId: "0x026D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade15_advanced_early2022",
      name: "Razer Blade 15 Advanced Early 2022",
      productId: "0x028A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade162023",
      name: "Razer Blade 16 2023",
      productId: "0x029F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade162025",
      name: "Razer Blade 16 2025",
      productId: "0x02C6",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade172022",
      name: "Razer Blade 17 2022",
      productId: "0x028B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade17_pro2021",
      name: "Razer Blade 17 Pro 2021",
      productId: "0x0279",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade17_pro_early2021",
      name: "Razer Blade 17 Pro Early 2021",
      productId: "0x026E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade182023",
      name: "Razer Blade 18 2023",
      productId: "0x02A0",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade182024",
      name: "Razer Blade 18 2024",
      productId: "0x02B8",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade182025",
      name: "Razer Blade 18 2025",
      productId: "0x02C7",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_2018",
      name: "Razer Blade 15 (2018)",
      productId: "0x0233",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_2018_base",
      name: "Razer Blade 15 (2018) Base Model",
      productId: "0x023B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_2018_mercury",
      name: "Razer Blade 2018 Mercury",
      productId: "0x0240",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_2019_adv",
      name: "Razer Blade 15 (2019) Advanced",
      productId: "0x023A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_2019_base",
      name: "Razer Blade 15 (2019) Base Model",
      productId: "0x0246",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_advanced_late2019",
      name: "Razer Blade Advanced Late 2019",
      productId: "0x024B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_early2020_base",
      name: "Razer Blade Early 2020 Base",
      productId: "0x0255",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_early2021_base",
      name: "Razer Blade Early 2021 Base",
      productId: "0x026F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_early2022_base",
      name: "Razer Blade Early 2022 Base",
      productId: "0x027A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_late2020_base",
      name: "Razer Blade Late 2020 Base",
      productId: "0x0268",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_late_2016",
      name: "Razer Blade Late 2016",
      productId: "0x0224",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_mid_2019_mercury",
      name: "Razer Blade 15 (Mid 2019) Mercury White",
      productId: "0x0245",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_pro2019",
      name: "Razer Blade Pro 2019",
      productId: "0x0234",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_pro_2017",
      name: "Razer Blade Pro (2017)",
      productId: "0x0225",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_pro_2017_fullhd",
      name: "Razer Blade Pro 2017 FullHD",
      productId: "0x022F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_pro_early2020",
      name: "Razer Blade Pro Early 2020",
      productId: "0x0256",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_pro_late2019",
      name: "Razer Blade Pro Late 2019",
      productId: "0x024C",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_pro_late_2016",
      name: "Razer Blade Pro Late 2016",
      productId: "0x0210",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_qhd",
      name: "Razer Blade Stealth (QHD)",
      productId: "0x020F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth",
      name: "Razer Blade Stealth",
      productId: "0x0205",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_2019",
      name: "Razer Blade Stealth (2019)",
      productId: "0x0239",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_early2020",
      name: "Razer Blade Stealth Early 2020",
      productId: "0x0252",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_late2020",
      name: "Razer Blade Stealth Late 2020",
      productId: "0x0259",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_late_2016",
      name: "Razer Blade Stealth (Late 2016)",
      productId: "0x0220",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_late_2017",
      name: "Razer Blade Stealth (Late 2017)",
      productId: "0x0232",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_late_2019",
      name: "Razer Blade Stealth (Late 2019)",
      productId: "0x024A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_stealth_mid_2017",
      name: "Razer Blade Stealth (Mid 2017)",
      productId: "0x022D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "blade_studio_edition_2019",
      name: "Razer Blade Studio Edition 2019",
      productId: "0x024D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "book2020",
      name: "Razer Book 2020",
      productId: "0x026A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "charging_pad_chroma",
      name: "Razer Charging Pad Chroma",
      productId: "0x0F26",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "chroma_argb",
      name: "Razer Chroma ARGB",
      productId: "0x0F1F",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "chroma_base",
      name: "Razer Chroma Base",
      productId: "0x0F08",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "chroma_hdk",
      name: "Razer Chroma HDK",
      productId: "0x0F09",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "chroma_mug",
      name: "Razer Chroma Mug",
      productId: "0x0F07",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "cobra",
      name: "Razer Cobra",
      productId: "0x00A3",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 8500,
      pollRates: [125, 500, 1000],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "cobra_pro_wired",
      name: "Razer Cobra Pro Wired",
      productId: "0x00AF",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "cobra_pro_wireless",
      name: "Razer Cobra Pro Wireless",
      productId: "0x00B0",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "core",
      name: "Razer Core",
      productId: "0x0215",
      kind: .egpu,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "core_x_chroma",
      name: "Razer Core X Chroma",
      productId: "0x0F1A",
      kind: .egpu,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "cynosa_chroma",
      name: "Razer Cynosa Chroma",
      productId: "0x022A",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "cynosa_chroma_pro",
      name: "Razer Cynosa Chroma Pro",
      productId: "0x022C",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "cynosa_lite",
      name: "Razer Cynosa Lite",
      productId: "0x023F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "cynosa_v2",
      name: "Razer Cynosa V2",
      productId: "0x025E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "death_adder2000",
      name: "Razer DeathAdder 2000",
      productId: "0x004F",
      kind: .mouse,
      featureKeys: [.none, .breathe, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 2000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "death_adder3_5_g_black",
      name: "Razer DeathAdder 3.5G Black",
      productId: "0x0029",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi],
      dpiMax: 3500,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v2_lite",
      name: "Razer DeathAdder V2 Lite",
      productId: "0x00A1",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 8500,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v2_x_hyper_speed",
      name: "Razer DeathAdder V2 X HyperSpeed",
      productId: "0x009C",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 14000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3",
      name: "Razer DeathAdder V3",
      productId: "0x00B2",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi],
      dpiMax: 30000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_hyper_speed_wired",
      name: "Razer DeathAdder V3 HyperSpeed Wired",
      productId: "0x00C4",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 26000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_hyper_speed_wireless",
      name: "Razer DeathAdder V3 HyperSpeed Wireless",
      productId: "0x00C5",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 26000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_pro_wired",
      name: "Razer DeathAdder V3 Pro Wired",
      productId: "0x00B6",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_pro_wired_alternate",
      name: "Razer DeathAdder V3 Pro Wired Alternate",
      productId: "0x00C2",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_pro_wireless",
      name: "Razer DeathAdder V3 Pro Wireless",
      productId: "0x00B7",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v3_pro_wireless_alternate",
      name: "Razer DeathAdder V3 Pro Wireless Alternate",
      productId: "0x00C3",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v4_pro_wired",
      name: "Razer DeathAdder V4 Pro Wired",
      productId: "0x00BE",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 45000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_adder_v4_pro_wireless",
      name: "Razer DeathAdder V4 Pro Wireless",
      productId: "0x00BF",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 45000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_stalker_essential",
      name: "Razer DeathStalker Essential",
      productId: "0x0118",
      kind: .keyboard,
      featureKeys: [],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_stalker_v2_pro_tkl_wired",
      name: "Razer DeathStalker V2 Pro TKL Wired",
      productId: "0x0298",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_stalker_v2_pro_tkl_wireless",
      name: "Razer DeathStalker V2 Pro TKL Wireless",
      productId: "0x0296",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_stalker_v2_pro_wired",
      name: "Razer DeathStalker V2 Pro Wired",
      productId: "0x0292",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "death_stalker_v2_pro_wireless",
      name: "Razer DeathStalker V2 Pro Wireless",
      productId: "0x0290",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "deathadder_1800",
      name: "Razer DeathAdder 1800",
      productId: "0x0038",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 1800,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "deathadder_2013",
      name: "Razer DeathAdder 2013",
      productId: "0x0037",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "deathadder_3500",
      name: "Razer DeathAdder 3500",
      productId: "0x0054",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 3500,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_3_5g",
      name: "Razer DeathAdder 3.5G",
      productId: "0x0016",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 3500,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "deathadder_chroma",
      name: "Razer DeathAdder Chroma",
      productId: "0x0043",
      kind: .mouse,
      featureKeys: [.staticLighting, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 10000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_elite",
      name: "Razer DeathAdder Elite",
      productId: "0x005C",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_essential",
      name: "Razer DeathAdder Essential",
      productId: "0x006E",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_essential_2021",
      name: "Razer DeathAdder Essential (2021)",
      productId: "0x0098",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_essential_white_edition",
      name: "Razer DeathAdder Essential (White Edition)",
      productId: "0x0071",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_v2",
      name: "Razer DeathAdder V2",
      productId: "0x0084",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_v2_mini",
      name: "Razer DeathAdder V2 Mini",
      productId: "0x008C",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 8500,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_v2_pro_wired",
      name: "Razer DeathAdder V2 Pro Wired",
      productId: "0x007C",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "deathadder_v2_pro_wireless",
      name: "Razer DeathAdder V2 Pro Wireless",
      productId: "0x007D",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "deathstalker_chroma",
      name: "Razer Deathstalker Chroma",
      productId: "0x0204",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "deathstalker_expert",
      name: "Razer Deathstalker Expert",
      productId: "0x0202",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "deathstalker_v2",
      name: "Razer Deathstalker V2",
      productId: "0x0295",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "diamondback_chroma",
      name: "Razer Diamondback Chroma",
      productId: "0x004C",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "firefly",
      name: "Razer Firefly",
      productId: "0x0C00",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "firefly_hyperflux",
      name: "Razer Firefly Hyperflux",
      productId: "0x0068",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "firefly_v2",
      name: "Razer Firefly V2",
      productId: "0x0C04",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "firefly_v2_pro",
      name: "Razer Firefly V2 Pro",
      productId: "0x0C08",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "goliathus_chroma",
      name: "Razer Goliathus Chroma",
      productId: "0x0C01",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "goliathus_chroma3_xl",
      name: "Razer Goliathus Chroma 3 XL",
      productId: "0x0C06",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "goliathus_chroma_extended",
      name: "Razer Goliathus Chroma Extended",
      productId: "0x0C02",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman",
      name: "Razer Huntsman",
      productId: "0x0227",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_elite",
      name: "Razer Huntsman Elite",
      productId: "0x0226",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_mini",
      name: "Razer Huntsman Mini",
      productId: "0x0257",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_mini_analog",
      name: "Razer Huntsman Mini Analog",
      productId: "0x0282",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "huntsman_mini_jp",
      name: "Razer Huntsman Mini (JP)",
      productId: "0x0269",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_te",
      name: "Razer Huntsman Tournament Edition",
      productId: "0x0243",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v2",
      name: "Razer Huntsman V2",
      productId: "0x026C",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v2_analog",
      name: "Razer Huntsman V2 Analog",
      productId: "0x0266",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v2_tkl",
      name: "Razer Huntsman V2 TKL",
      productId: "0x026B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v3_pro",
      name: "Razer Huntsman V3 Pro",
      productId: "0x02A6",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v3_pro8_k_hz",
      name: "Razer Huntsman V3 Pro 8KHz",
      productId: "0x02CF",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v3_pro_mini",
      name: "Razer Huntsman V3 Pro Mini",
      productId: "0x02B0",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "huntsman_v3_pro_tkl",
      name: "Razer Huntsman V3 Pro TKL",
      productId: "0x02A7",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "hyper_polling_wireless_dongle",
      name: "Razer Hyper Polling Wireless Dongle",
      productId: "0x00B3",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "imperator",
      name: "Razer Imperator",
      productId: "0x002F",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken",
      name: "Razer Kraken 7.1 Chroma",
      productId: "0x0504",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_classic",
      name: "Razer Kraken 7.1",
      productId: "0x0501",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_classic_alt",
      name: "Razer Kraken 7.1",
      productId: "0x0506",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_kitty_edition",
      name: "Razer Kraken Kitty Edition",
      productId: "0x0F19",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_kitty_v2",
      name: "Razer Kraken Kitty V2",
      productId: "0x0560",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_tournament_edition",
      name: "Razer Kraken Tournament Edition",
      productId: "0x0520",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_ultimate",
      name: "Razer Kraken Ultimate",
      productId: "0x0527",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "kraken_v2",
      name: "Razer Kraken V2",
      productId: "0x0510",
      kind: .headphone,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "lancehead_te_wired",
      name: "Razer Lancehead Tournament Edition",
      productId: "0x0060",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "lancehead_wired",
      name: "Razer Lancehead Wired",
      productId: "0x0059",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "lancehead_wireless",
      name: "Razer Lancehead Wireless",
      productId: "0x005A",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "lancehead_wireless_receiver",
      name: "Razer Lancehead (Receiver)",
      productId: "0x006F",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "lancehead_wireless_wired",
      name: "Razer Lancehead Wireless Wired",
      productId: "0x0070",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "laptop_stand_chroma",
      name: "Razer Laptop Stand Chroma",
      productId: "0x0F0D",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "laptop_stand_chroma_v2",
      name: "Razer Laptop Stand Chroma V2",
      productId: "0x0F2B",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "lian_li_o11_dynamic",
      name: "Razer Lian Li O11 Dynamic",
      productId: "0x0F13",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "mamba_2012_wired",
      name: "Razer Mamba 2012 Wired",
      productId: "0x0024",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.scroll]
    ),
    LegacyDeviceDefinition(
      id: "mamba_2012_wireless",
      name: "Razer Mamba 2012 Wireless",
      productId: "0x0025",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: [.scroll]
    ),
    LegacyDeviceDefinition(
      id: "mamba_elite",
      name: "Razer Mamba Elite",
      productId: "0x006C",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "mamba_te_wired",
      name: "Razer Mamba Tournament Edition",
      productId: "0x0046",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "mamba_wired",
      name: "Razer Mamba Wired",
      productId: "0x0044",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "mamba_wireless",
      name: "Razer Mamba Wireless",
      productId: "0x0045",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "mamba_wireless_receiver",
      name: "Razer Mamba (Receiver)",
      productId: "0x0072",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "mamba_wireless_wired",
      name: "Razer Mamba Wireless Wired",
      productId: "0x0073",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "mouse_bungee_v3_chroma",
      name: "Razer Mouse Bungee V3 Chroma",
      productId: "0x0F1D",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "mouse_charging_dock",
      name: "Razer Mouse Charging Dock",
      productId: "0x007E",
      kind: .mouseDock,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .battery],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "mouse_dock_pro",
      name: "Razer Mouse Dock Pro",
      productId: "0x00A4",
      kind: .mouseDock,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga",
      name: "Razer Naga",
      productId: "0x0015",
      kind: .mouse,
      featureKeys: [.none, .pollRate, .dpi],
      dpiMax: 5600,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_2012",
      name: "Razer Naga 2012",
      productId: "0x002E",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 5600,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_2014",
      name: "Razer Naga 2014",
      productId: "0x0040",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_chroma",
      name: "Razer Naga Chroma",
      productId: "0x0053",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "naga_epic",
      name: "Razer Naga Epic",
      productId: "0x001F",
      kind: .mouse,
      featureKeys: [.mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 5600,
      pollRates: [],
      brightnessZones: [.scroll]
    ),
    LegacyDeviceDefinition(
      id: "naga_epic_chroma_wired",
      name: "Razer Naga Epic Chroma Wired",
      productId: "0x003E",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: [.matrix, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "naga_epic_chroma_wireless",
      name: "Razer Naga Epic Chroma Wireless",
      productId: "0x003F",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: [.matrix, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "naga_hex",
      name: "Razer Naga Hex",
      productId: "0x0041",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 5600,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_hex_red",
      name: "Razer Naga Hex (Red)",
      productId: "0x0036",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 5600,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_hex_v2",
      name: "Razer Naga Hex V2",
      productId: "0x0050",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo, .scroll]
    ),
    LegacyDeviceDefinition(
      id: "naga_lefthanded_2020",
      name: "Razer Naga Left Handed Edition 2020",
      productId: "0x008D",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo, .scroll, .right]
    ),
    LegacyDeviceDefinition(
      id: "naga_pro_wired",
      name: "Razer Naga Pro - Wired",
      productId: "0x008F",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "naga_pro_wireless",
      name: "Razer Naga Pro - Wireless",
      productId: "0x0090",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "naga_trinity",
      name: "Razer Naga Trinity",
      productId: "0x0067",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "naga_v2_hyper_speed_receiver",
      name: "Razer Naga V2 HyperSpeed Receiver",
      productId: "0x00B4",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "naga_v2_pro_wired",
      name: "Razer Naga V2 Pro Wired",
      productId: "0x00A7",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "naga_v2_pro_wireless",
      name: "Razer Naga V2 Pro Wireless",
      productId: "0x00A8",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "naga_x",
      name: "Razer Naga X",
      productId: "0x0096",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: [.matrix, .logo, .scroll, .left, .right]
    ),
    LegacyDeviceDefinition(
      id: "nommo_chroma",
      name: "Razer Nommo Chroma",
      productId: "0x0517",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "nommo_pro",
      name: "Razer Nommo Pro",
      productId: "0x0518",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "nostromo",
      name: "Razer Nostromo",
      productId: "0x0111",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "orbweaver",
      name: "Razer Orbweaver",
      productId: "0x0113",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "orbweaver_chroma",
      name: "Razer Orbweaver Chroma",
      productId: "0x0207",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "ornata",
      name: "Razer Ornata",
      productId: "0x021F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "ornata_chroma",
      name: "Razer Ornata Chroma",
      productId: "0x021E",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "ornata_v2",
      name: "Razer Ornata V2",
      productId: "0x025D",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "ornata_v3",
      name: "Razer Ornata V3",
      productId: "0x02A1",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "ornata_v3_alternate",
      name: "Razer Ornata V3 Alternate",
      productId: "0x028F",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "ornata_v3_tenkeyless",
      name: "Razer Ornata V3 Tenkeyless",
      productId: "0x02A3",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "ornata_v3_x",
      name: "Razer Ornata V3 X",
      productId: "0x0294",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "ornata_v3_x_alternate",
      name: "Razer Ornata V3 X Alternate",
      productId: "0x02A2",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .spectrum, .breathe, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "orochi_2011",
      name: "Razer Orochi 2011",
      productId: "0x0013",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 4000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "orochi_2013",
      name: "Razer Orochi 2013",
      productId: "0x0039",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 6400,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "orochi_chroma",
      name: "Razer Orochi Chroma",
      productId: "0x0048",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "orochi_v2_bluetooth",
      name: "Razer Orochi V2 (Bluetooth)",
      productId: "0x0095",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "orochi_v2_receiver",
      name: "Razer Orochi Chroma (Receiver)",
      productId: "0x0094",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 18000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "ouroboros",
      name: "Razer Ouroboros",
      productId: "0x0032",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: [.scroll]
    ),
    LegacyDeviceDefinition(
      id: "pro_click_mini_receiver",
      name: "Razer Pro Click Mini Receiver",
      productId: "0x009A",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 12000,
      pollRates: [125, 500, 1000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "pro_click_receiver",
      name: "Razer Pro Click Receiver",
      productId: "0x0077",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [125, 500, 1000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "pro_click_v2_vertical_edition_wired",
      name: "Razer Pro Click V2 Vertical Edition Wired",
      productId: "0x00C7",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 250, 500, 1000],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "pro_click_v2_vertical_edition_wireless",
      name: "Razer Pro Click V2 Vertical Edition Wireless",
      productId: "0x00C8",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 250, 500, 1000],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "pro_click_v2_wired",
      name: "Razer Pro Click V2 Wired",
      productId: "0x00D0",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 250, 500, 1000],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "pro_click_v2_wireless",
      name: "Razer Pro Click V2 Wireless",
      productId: "0x00D1",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 250, 500, 1000],
      brightnessZones: [.matrix]
    ),
    LegacyDeviceDefinition(
      id: "pro_click_wired",
      name: "Razer Pro Click Wired",
      productId: "0x0080",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [125, 500, 1000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "raptor27",
      name: "Razer Raptor 27",
      productId: "0x0F12",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "strider_chroma",
      name: "Razer Strider Chroma",
      productId: "0x0C05",
      kind: .mouseMat,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "taipan",
      name: "Razer Taipan",
      productId: "0x0034",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .waveSimple, .spectrum, .reactive, .breathe, .oldMouseEffects, .pollRate, .dpi, .battery],
      dpiMax: 8200,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "tartarus",
      name: "Razer Tartarus",
      productId: "0x0201",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "tartarus_chroma",
      name: "Razer Tartarus Chroma",
      productId: "0x0208",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "tartarus_pro",
      name: "Razer Tartarus Pro",
      productId: "0x0244",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .brightness, .ripple, .wheel],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "tartarus_v2",
      name: "Razer Tartarus V2",
      productId: "0x022B",
      kind: .keyboard,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .reactive, .breathe, .starlight, .ripple, .wheel, .brightness],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: [.all]
    ),
    LegacyDeviceDefinition(
      id: "thunderbolt_4_dock_chroma",
      name: "Razer Thunderbolt 4 Dock Chroma",
      productId: "0x0F21",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "tomahawk_atx",
      name: "Razer Tomahawk ATX",
      productId: "0x0F17",
      kind: .accessory,
      featureKeys: [.none, .staticLighting, .waveExtended, .spectrum, .breathe],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper",
      name: "Razer Viper",
      productId: "0x0078",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 16000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "viper_8khz",
      name: "Razer Viper 8Khz",
      productId: "0x0091",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "viper_mini",
      name: "Razer Viper Mini",
      productId: "0x008A",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 8500,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "viper_mini_se_wired",
      name: "Razer Viper Mini SE Wired",
      productId: "0x009E",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 500, 1000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_mini_se_wireless",
      name: "Razer Viper Mini SE Wireless",
      productId: "0x009F",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_ultimate_wired",
      name: "Razer Viper Ultimate Wired",
      productId: "0x007A",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "viper_ultimate_wireless",
      name: "Razer Viper Ultimate Wireless",
      productId: "0x007B",
      kind: .mouse,
      featureKeys: [.none, .staticLighting, .spectrum, .reactive, .breathe, .oldMouseEffects, .mouseBrightness, .pollRate, .dpi, .battery],
      dpiMax: 20000,
      pollRates: [],
      brightnessZones: [.logo]
    ),
    LegacyDeviceDefinition(
      id: "viper_v2_pro_wired",
      name: "Razer Viper V2 Pro Wired",
      productId: "0x00A5",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_v2_pro_wireless",
      name: "Razer Viper V2 Pro Wireless",
      productId: "0x00A6",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_v3_hyper_speed",
      name: "Razer Viper V3 HyperSpeed",
      productId: "0x00B8",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 30000,
      pollRates: [],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_v3_pro_wired",
      name: "Razer Viper V3 Pro Wired",
      productId: "0x00C0",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [125, 500, 1000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "viper_v3_pro_wireless",
      name: "Razer Viper V3 Pro Wireless",
      productId: "0x00C1",
      kind: .mouse,
      featureKeys: [.pollRate, .dpi, .battery],
      dpiMax: 35000,
      pollRates: [125, 500, 1000, 2000, 4000, 8000],
      brightnessZones: []
    ),
    LegacyDeviceDefinition(
      id: "wolverine_v3_pro",
      name: "Razer Wolverine V3 Pro",
      productId: "0x0A3F",
      kind: .gameController,
      featureKeys: [],
      dpiMax: nil,
      pollRates: [],
      brightnessZones: []
    ),
  ]

  public static let devices: [NativeDevice] = definitions.map(\.nativeDevice)
}
