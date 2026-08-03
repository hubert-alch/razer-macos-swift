import NativeRazerCore
import SwiftUI

struct SidebarView: View {
  let devices: [NativeDevice]
  @Binding var selection: NativeDevice.ID?
  @Binding var searchText: String
  @Environment(\.appLanguage) private var language

  private var sections: DeviceSidebarSections {
    DeviceSidebarSections(devices: devices, searchText: searchText)
  }

  var body: some View {
    List(selection: $selection) {
      Section(AppText.string(.connectedDevices, language: language)) {
        if sections.connectedDevices.isEmpty {
          placeholderRow(.noConnectedDevices)
        } else {
          deviceRows(sections.connectedDevices)
        }
      }

      Section(AppText.string(.supportedDisconnectedDevices, language: language)) {
        if sections.supportedDevices.isEmpty {
          placeholderRow(.noSupportedDisconnectedDevices)
        } else {
          deviceRows(sections.supportedDevices)
        }
      }
    }
    .listStyle(.sidebar)
    .searchable(
      text: $searchText,
      placement: .sidebar,
      prompt: AppText.string(.searchDevices, language: language)
    )
  }

  @ViewBuilder
  private func deviceRows(_ devices: [NativeDevice]) -> some View {
    ForEach(devices) { device in
      HStack(spacing: 10) {
        Image(systemName: iconName(for: device.kind))
          .foregroundStyle(.secondary)
          .frame(width: 16)

        VStack(alignment: .leading, spacing: 2) {
          Text(device.name)
            .lineLimit(1)

          Text(device.productId)
            .font(.caption)
            .foregroundStyle(.secondary)
            .lineLimit(1)
        }
      }
      .tag(device.id)
    }
  }

  private func placeholderRow(_ key: AppStringKey) -> some View {
    Text(AppText.string(key, language: language))
      .font(.caption)
      .foregroundStyle(.secondary)
  }

  private func iconName(for kind: NativeDeviceKind) -> String {
    switch kind {
    case .keyboard:
      "keyboard"
    case .mouse, .mouseDock:
      "computermouse"
    case .mouseMat:
      "rectangle.grid.2x2"
    case .headphone:
      "headphones"
    case .egpu:
      "externaldrive"
    case .gameController:
      "gamecontroller"
    case .accessory:
      "sparkles"
    case .unknown:
      "questionmark.square"
    }
  }
}
