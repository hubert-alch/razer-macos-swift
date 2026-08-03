import Foundation

public struct NativeDevice: Identifiable, Equatable, Sendable {
  public let id: String
  public let name: String
  public let productId: String
  public let kind: NativeDeviceKind
  public var connection: String
  public let capabilities: [DeviceCapability]
  public var bridgeStatus: String
  public var bridgeStatusMessage: AppMessage
  public var hardwareInternalId: Int?
  public var controlConfiguration: DeviceControlConfiguration
  public var controlState: DeviceControlState

  public init(
    id: String,
    name: String,
    productId: String,
    kind: NativeDeviceKind = .unknown,
    connection: String,
    capabilities: [DeviceCapability],
    bridgeStatus: String,
    bridgeStatusMessage: AppMessage? = nil,
    hardwareInternalId: Int? = nil,
    controlConfiguration: DeviceControlConfiguration = .none,
    controlState: DeviceControlState = DeviceControlState()
  ) {
    self.id = id
    self.name = name
    self.productId = productId
    self.kind = kind
    self.connection = connection
    self.capabilities = capabilities
    self.bridgeStatus = bridgeStatus
    self.bridgeStatusMessage = bridgeStatusMessage ?? .passthrough(bridgeStatus)
    self.hardwareInternalId = hardwareInternalId
    self.controlConfiguration = controlConfiguration
    self.controlState = controlState
  }

  public mutating func setBridgeStatus(_ message: AppMessage) {
    bridgeStatusMessage = message
    bridgeStatus = message.localized(language: .english)
  }

  public func localizedConnection(language: AppLanguage) -> String {
    if connection == "USB receiver / wired" {
      return AppText.string(.connectionUSBReceiverWired, language: language)
    }

    if connection.hasPrefix("librazermacos internal #") {
      let identifier = connection.replacingOccurrences(of: "librazermacos internal #", with: "")
      return AppText.formatted(
        .connectionLibrazermacosInternal,
        language: language,
        identifier
      )
    }

    return connection
  }
}

public enum NativeDeviceKind: String, CaseIterable, Identifiable, Sendable {
  case accessory
  case egpu
  case gameController = "gamecontroller"
  case headphone
  case keyboard
  case mouse
  case mouseDock = "mousedock"
  case mouseMat = "mousemat"
  case unknown

  public var id: String { rawValue }
}
