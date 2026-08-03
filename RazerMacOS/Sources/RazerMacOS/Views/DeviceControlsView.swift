import NativeRazerCore
import SwiftUI

struct DeviceControlsView: View {
  let device: NativeDevice
  let onSetDPI: (Int) -> Void
  let onSetPollingRate: (Int) -> Void
  let onSetLightingMode: (LightingMode) -> Void
  let onSetStaticColor: (RazerColor) -> Void
  let onSetBrightness: (Int, BrightnessZone) -> Void

  @State private var draftDPI: Double = 1_600
  @State private var draftPollingRate: Int = 1_000
  @State private var draftLightingMode: LightingMode = .none
  @State private var draftRed: Double = 0
  @State private var draftGreen: Double = 255
  @State private var draftBlue: Double = 0
  @State private var draftBrightness: [BrightnessZone: Double] = [:]
  @Environment(\.appLanguage) private var language

  var body: some View {
    GroupBox(AppText.string(.deviceControls, language: language)) {
      VStack(alignment: .leading, spacing: 18) {
        if device.kind == .gameController {
          GameControllerControlsView(
            deviceName: device.name,
            usbConnected: device.hardwareInternalId != nil
          )
        }

        if !hasHardwareControls {
          Label(
            AppText.string(.controlsUnavailableForDevice, language: language),
            systemImage: "info.circle"
          )
          .foregroundStyle(.secondary)
        }

        if let dpiConfiguration = device.controlConfiguration.dpi {
          dpiControl(dpiConfiguration)
        }

        if device.controlConfiguration.supportsPollingRate {
          pollingRateControl
        }

        if device.capabilities.contains(.battery) {
          batteryStatus
        }

        if device.controlConfiguration.supportsLighting {
          lightingControls
        }
      }
      .onAppear {
        syncDrafts()
      }
      .onChange(of: device) {
        syncDrafts()
      }
    }
  }

  private var hasHardwareControls: Bool {
    device.kind == .gameController
      || device.controlConfiguration.dpi != nil
      || device.controlConfiguration.supportsPollingRate
      || device.capabilities.contains(.battery)
      || device.controlConfiguration.supportsLighting
  }

  private func dpiControl(_ configuration: DPIConfiguration) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Label(AppText.string(.capabilityDPI, language: language), systemImage: "scope")
          .font(.headline)

        Spacer()

        Text("\(Int(draftDPI))")
          .monospacedDigit()
          .foregroundStyle(.secondary)
      }

      Slider(
        value: $draftDPI,
        in: Double(configuration.min)...Double(configuration.max),
        step: Double(configuration.step)
      )

      HStack {
        Text("\(configuration.min)")
        Spacer()
        Text("\(configuration.max)")
      }
      .font(.caption)
      .foregroundStyle(.secondary)

      Button {
        onSetDPI(Int(draftDPI))
      } label: {
        Label(AppText.string(.setDPI, language: language), systemImage: "checkmark.circle")
      }
      .buttonStyle(.borderedProminent)
    }
  }

  private var pollingRateControl: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.pollingRate, language: language), systemImage: "speedometer")
        .font(.headline)

      Picker(AppText.string(.pollingRate, language: language), selection: $draftPollingRate) {
        ForEach(device.controlConfiguration.pollingRates, id: \.self) { rate in
          Text("\(rate) Hz").tag(rate)
        }
      }
      .pickerStyle(.segmented)

      Button {
        onSetPollingRate(draftPollingRate)
      } label: {
        Label(AppText.string(.savePollingRate, language: language), systemImage: "checkmark.circle")
      }
    }
  }

  private var batteryStatus: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.battery, language: language), systemImage: "battery.75percent")
        .font(.headline)

      if let batteryLevel = device.controlState.batteryLevel {
        ProgressView(value: Double(batteryLevel), total: 100) {
          Text(
            device.controlState.isCharging == true
              ? AppText.string(.charging, language: language)
              : AppText.string(.battery, language: language)
          )
        } currentValueLabel: {
          Text("\(batteryLevel)%")
        }
      } else {
        Text(AppText.string(.batteryStatusUnavailable, language: language))
          .foregroundStyle(.secondary)
      }
    }
  }

  private var lightingControls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.lighting, language: language), systemImage: "lightbulb")
        .font(.headline)

      if !device.controlConfiguration.lightingModes.isEmpty {
        Picker(AppText.string(.lightingEffect, language: language), selection: $draftLightingMode) {
          ForEach(device.controlConfiguration.lightingModes) { mode in
            Text(AppText.lightingModeName(mode, language: language)).tag(mode)
          }
        }
        .pickerStyle(.menu)

        Button {
          onSetLightingMode(draftLightingMode)
        } label: {
          Label(AppText.string(.lightingApplyEffect, language: language), systemImage: "sparkles")
        }
      }

      if device.controlConfiguration.supportsStaticColor {
        staticColorControls
      }

      if !device.controlConfiguration.brightnessZones.isEmpty {
        brightnessControls
      }

      Text(AppText.string(.lightingPreviewOnly, language: language))
        .font(.caption)
        .foregroundStyle(.secondary)
    }
  }

  private var staticColorControls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.lightingStaticColor, language: language), systemImage: "paintpalette")
        .font(.subheadline)

      colorSlider(.lightingRed, value: $draftRed)
      colorSlider(.lightingGreen, value: $draftGreen)
      colorSlider(.lightingBlue, value: $draftBlue)

      Button {
        onSetStaticColor(
          RazerColor(
            red: Int(draftRed),
            green: Int(draftGreen),
            blue: Int(draftBlue)
          )
        )
      } label: {
        Label(AppText.string(.lightingApplyColor, language: language), systemImage: "checkmark.circle")
      }
    }
  }

  private var brightnessControls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.lightingBrightness, language: language), systemImage: "sun.max")
        .font(.subheadline)

      ForEach(device.controlConfiguration.brightnessZones) { zone in
        HStack {
          Text(AppText.brightnessZoneName(zone, language: language))
            .frame(width: 92, alignment: .leading)
          Slider(value: brightnessBinding(for: zone), in: 0...100, step: 1)
          Text("\(Int(draftBrightness[zone] ?? 100))")
            .monospacedDigit()
            .frame(width: 34, alignment: .trailing)
          Button {
            onSetBrightness(Int(draftBrightness[zone] ?? 100), zone)
          } label: {
            Image(systemName: "checkmark.circle")
          }
          .buttonStyle(.borderless)
          .help(AppText.string(.lightingBrightness, language: language))
        }
      }
    }
  }

  private func colorSlider(_ key: AppStringKey, value: Binding<Double>) -> some View {
    HStack {
      Text(AppText.string(key, language: language))
        .frame(width: 64, alignment: .leading)
      Slider(value: value, in: 0...255, step: 1)
      Text("\(Int(value.wrappedValue))")
        .monospacedDigit()
        .frame(width: 38, alignment: .trailing)
    }
  }

  private func brightnessBinding(for zone: BrightnessZone) -> Binding<Double> {
    Binding(
      get: {
        draftBrightness[zone] ?? Double(device.controlState.brightness[zone] ?? 100)
      },
      set: { newValue in
        draftBrightness[zone] = newValue
      }
    )
  }

  private func syncDrafts() {
    if let dpi = device.controlState.dpi {
      draftDPI = Double(dpi)
    }

    if let pollingRate = device.controlState.pollingRate,
       device.controlConfiguration.pollingRates.contains(pollingRate) {
      draftPollingRate = pollingRate
    } else if let firstRate = device.controlConfiguration.pollingRates.first {
      draftPollingRate = firstRate
    }

    if device.controlConfiguration.lightingModes.contains(device.controlState.activeMode) {
      draftLightingMode = device.controlState.activeMode
    } else if let firstMode = device.controlConfiguration.lightingModes.first {
      draftLightingMode = firstMode
    }

    draftRed = Double(device.controlState.staticColor.red)
    draftGreen = Double(device.controlState.staticColor.green)
    draftBlue = Double(device.controlState.staticColor.blue)
    draftBrightness = Dictionary(
      uniqueKeysWithValues: device.controlConfiguration.brightnessZones.map { zone in
        (zone, Double(device.controlState.brightness[zone] ?? 100))
      }
    )
  }
}
