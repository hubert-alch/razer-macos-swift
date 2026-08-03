import CoreHaptics
import Foundation
import GameController

struct GameControllerDescriptor: Equatable, Identifiable {
  let id: String
  let vendorName: String
  let productCategory: String
}

enum GameControllerMatcher {
  static func match(
    preferredDeviceName: String,
    candidates: [GameControllerDescriptor]
  ) -> GameControllerDescriptor? {
    let preferred = normalized(preferredDeviceName)
    if let namedMatch = candidates.first(where: { candidate in
      let identity = normalized(candidate.vendorName + candidate.productCategory)
      return identity.contains(preferred) || preferred.contains(identity)
        || (identity.contains("razer") && identity.contains("wolverine"))
    }) {
      return namedMatch
    }

    return candidates.count == 1 ? candidates[0] : nil
  }

  private static func normalized(_ value: String) -> String {
    String(value.lowercased().filter { $0.isLetter || $0.isNumber })
  }
}

struct GameControllerButtonSnapshot: Equatable, Identifiable {
  let id: String
  let name: String
  let value: Float
  let isPressed: Bool
}

struct GameControllerPadSnapshot: Equatable, Identifiable {
  let id: String
  let name: String
  let x: Float
  let y: Float
}

struct GameControllerRuntimeSnapshot: Equatable {
  let name: String
  let productCategory: String
  let buttons: [GameControllerButtonSnapshot]
  let pads: [GameControllerPadSnapshot]
  let batteryLevel: Int?
  let isCharging: Bool?
  let hasHaptics: Bool
  let hasLight: Bool
  let hasRemappedElements: Bool
}

@MainActor
enum GameControllerRuntime {
  static func matchingController(
    preferredDeviceName: String,
    controllers: [GCController] = GCController.controllers()
  ) -> GCController? {
    let descriptors = controllers.map(descriptor)
    guard let match = GameControllerMatcher.match(
      preferredDeviceName: preferredDeviceName,
      candidates: descriptors
    ) else {
      return nil
    }

    return controllers.first { descriptor(for: $0).id == match.id }
  }

  static func snapshot(for controller: GCController) -> GameControllerRuntimeSnapshot {
    let profile = controller.physicalInputProfile.capture()
    let buttons = profile.buttons.map { name, button in
      GameControllerButtonSnapshot(
        id: name,
        name: name,
        value: button.value,
        isPressed: button.isPressed
      )
    }
    .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

    let pads = profile.dpads.map { name, pad in
      GameControllerPadSnapshot(
        id: name,
        name: name,
        x: pad.xAxis.value,
        y: pad.yAxis.value
      )
    }
    .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

    let batteryLevel = controller.battery.map { battery in
      Int((battery.batteryLevel * 100).rounded())
    }
    let isCharging = controller.battery.map { battery in
      battery.batteryState == .charging || battery.batteryState == .full
    }

    return GameControllerRuntimeSnapshot(
      name: controller.vendorName ?? controller.productCategory,
      productCategory: controller.productCategory,
      buttons: buttons,
      pads: pads,
      batteryLevel: batteryLevel,
      isCharging: isCharging,
      hasHaptics: controller.haptics != nil,
      hasLight: controller.light != nil,
      hasRemappedElements: profile.hasRemappedElements
    )
  }

  static func setLight(
    on controller: GCController,
    red: Float,
    green: Float,
    blue: Float
  ) -> Bool {
    guard let light = controller.light else {
      return false
    }

    light.color = GCColor(red: red, green: green, blue: blue)
    return true
  }

  static func playHaptic(on controller: GCController) throws -> CHHapticEngine? {
    guard let engine = controller.haptics?.createEngine(withLocality: .default) else {
      return nil
    }

    try engine.start()
    let event = CHHapticEvent(
      eventType: .hapticContinuous,
      parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.65),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.35)
      ],
      relativeTime: 0,
      duration: 0.3
    )
    let pattern = try CHHapticPattern(events: [event], parameters: [])
    let player = try engine.makePlayer(with: pattern)
    try player.start(atTime: 0)
    return engine
  }

  private static func descriptor(for controller: GCController) -> GameControllerDescriptor {
    GameControllerDescriptor(
      id: String(ObjectIdentifier(controller).hashValue),
      vendorName: controller.vendorName ?? "",
      productCategory: controller.productCategory
    )
  }
}
