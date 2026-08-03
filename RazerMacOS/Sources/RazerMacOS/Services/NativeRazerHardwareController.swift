import Foundation
import NativeRazerBridgeC
import NativeRazerCore

struct HardwareMouseSnapshot: Equatable {
  let internalDeviceId: Int
  let productId: String
  let dpi: Int
  let pollingRate: Int
  let batteryLevel: Int?
  let isCharging: Bool?
}

struct HardwareDeviceSnapshot: Equatable {
  let internalDeviceId: Int
  let productId: String
  let kind: NativeDeviceKind
}

enum HardwareApplyResult: Equatable {
  case applied
  case previewOnly(AppMessage)
  case failed(AppMessage)
}

protocol NativeRazerHardwareControlling {
  func refreshDevices() -> [HardwareDeviceSnapshot]
  func refreshMice() -> [HardwareMouseSnapshot]
  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult
  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult
  func setLightingMode(_ mode: LightingMode, color: RazerColor, kind: NativeDeviceKind, internalDeviceId: Int?) -> HardwareApplyResult
  func setBrightness(_ brightness: Int, zone: BrightnessZone, kind: NativeDeviceKind, internalDeviceId: Int?) -> HardwareApplyResult
  func shutdown()
}

final class NativeRazerHardwareController: NativeRazerHardwareControlling {
  func refreshDevices() -> [HardwareDeviceSnapshot] {
    var snapshots = Array(
      repeating: NativeRazerDeviceSnapshot(),
      count: 32
    )
    let count = NativeRazerRefreshDevices(&snapshots, Int32(snapshots.count))

    guard count > 0 else {
      return []
    }

    return snapshots.prefix(Int(count)).map { snapshot in
      HardwareDeviceSnapshot(
        internalDeviceId: Int(snapshot.internalDeviceId),
        productId: productIdString(snapshot.productId),
        kind: deviceKind(Int(snapshot.deviceKind))
      )
    }
  }

  func refreshMice() -> [HardwareMouseSnapshot] {
    var snapshots = Array(
      repeating: NativeRazerMouseSnapshot(),
      count: 16
    )
    let count = NativeRazerRefreshMice(&snapshots, Int32(snapshots.count))

    guard count > 0 else {
      return []
    }

    return snapshots.prefix(Int(count)).map { snapshot in
      HardwareMouseSnapshot(
        internalDeviceId: Int(snapshot.internalDeviceId),
        productId: productIdString(snapshot.productId),
        dpi: Int(snapshot.dpi),
        pollingRate: Int(snapshot.pollingRate),
        batteryLevel: snapshot.batteryLevel >= 0 ? Int(snapshot.batteryLevel) : nil,
        isCharging: snapshot.batteryLevel >= 0 ? snapshot.charging == 1 : nil
      )
    }
  }

  func setDPI(_ dpi: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    guard let internalDeviceId else {
      return .previewOnly(.hardwareNoConnectedMouse)
    }

    let result = NativeRazerSetMouseDPI(Int32(internalDeviceId), UInt16(clamping: dpi))
    return result == 0 ? .applied : .failed(.hardwareRejectedDPI)
  }

  func setPollingRate(_ pollingRate: Int, internalDeviceId: Int?) -> HardwareApplyResult {
    guard let internalDeviceId else {
      return .previewOnly(.hardwareNoConnectedMouse)
    }

    let result = NativeRazerSetMousePollingRate(Int32(internalDeviceId), UInt16(clamping: pollingRate))
    return result == 0 ? .applied : .failed(.hardwareRejectedPollingRate)
  }

  func setLightingMode(_ mode: LightingMode, color: RazerColor, kind: NativeDeviceKind, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.lightingPreviewOnly)
  }

  func setBrightness(_ brightness: Int, zone: BrightnessZone, kind: NativeDeviceKind, internalDeviceId: Int?) -> HardwareApplyResult {
    .previewOnly(.lightingPreviewOnly)
  }

  func shutdown() {
    NativeRazerShutdown()
  }

  private func productIdString(_ productId: UInt16) -> String {
    "0x" + String(format: "%04X", productId)
  }

  private func deviceKind(_ rawValue: Int) -> NativeDeviceKind {
    switch rawValue {
    case 0:
      .accessory
    case 1:
      .egpu
    case 2:
      .headphone
    case 3:
      .keyboard
    case 4:
      .mouse
    case 5:
      .mouseDock
    case 6:
      .mouseMat
    case 7:
      .gameController
    default:
      .unknown
    }
  }

}
