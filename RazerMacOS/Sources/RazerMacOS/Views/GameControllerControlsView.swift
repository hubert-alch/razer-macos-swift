import CoreHaptics
import GameController
import NativeRazerCore
import SwiftUI

struct GameControllerControlsView: View {
  let deviceName: String
  let usbConnected: Bool

  @State private var red = 0.0
  @State private var green = 1.0
  @State private var blue = 0.0
  @State private var hapticEngine: CHHapticEngine?
  @State private var hapticError: String?
  @Environment(\.appLanguage) private var language

  var body: some View {
    TimelineView(.periodic(from: .now, by: 1.0 / 30.0)) { _ in
      if let controller = GameControllerRuntime.matchingController(
        preferredDeviceName: deviceName
      ) {
        controllerSurface(
          controller: controller,
          snapshot: GameControllerRuntime.snapshot(for: controller)
        )
      } else {
        waitingSurface
      }
    }
  }

  private var waitingSurface: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(
        AppText.string(.controllerInputMonitor, language: language),
        systemImage: "gamecontroller"
      )
      .font(.headline)

      Text(
        AppText.string(
          usbConnected ? .controllerSystemInputUnavailable : .controllerConnectPrompt,
          language: language
        )
      )
      .foregroundStyle(.secondary)
    }
  }

  @ViewBuilder
  private func controllerSurface(
    controller: GCController,
    snapshot: GameControllerRuntimeSnapshot
  ) -> some View {
    VStack(alignment: .leading, spacing: 18) {
      HStack(alignment: .firstTextBaseline) {
        Label(
          AppText.string(.controllerInputMonitor, language: language),
          systemImage: "gamecontroller.fill"
        )
        .font(.headline)

        Spacer()

        Text(snapshot.name)
          .foregroundStyle(.secondary)
      }

      Text(AppText.string(.controllerPressToTest, language: language))
        .font(.caption)
        .foregroundStyle(.secondary)

      if !snapshot.buttons.isEmpty {
        LazyVGrid(
          columns: [GridItem(.adaptive(minimum: 150), spacing: 8)],
          alignment: .leading,
          spacing: 8
        ) {
          ForEach(snapshot.buttons) { button in
            HStack(spacing: 8) {
              Circle()
                .fill(button.isPressed ? Color.accentColor : Color.secondary.opacity(0.25))
                .frame(width: 10, height: 10)
              Text(button.name)
                .lineLimit(1)
              Spacer()
              Text(button.value, format: .number.precision(.fractionLength(2)))
                .monospacedDigit()
                .foregroundStyle(.secondary)
            }
            .padding(8)
            .background(.quaternary.opacity(button.isPressed ? 1 : 0.45), in: RoundedRectangle(cornerRadius: 8))
          }
        }
      }

      if !snapshot.pads.isEmpty {
        VStack(alignment: .leading, spacing: 8) {
          Text(AppText.string(.controllerAxes, language: language))
            .font(.headline)

          ForEach(snapshot.pads) { pad in
            HStack {
              Text(pad.name)
              Spacer()
              Text("X \(pad.x, format: .number.precision(.fractionLength(2)))")
              Text("Y \(pad.y, format: .number.precision(.fractionLength(2)))")
            }
            .monospacedDigit()
          }
        }
      }

      if let batteryLevel = snapshot.batteryLevel {
        ProgressView(value: Double(batteryLevel), total: 100) {
          Text(
            snapshot.isCharging == true
              ? AppText.string(.charging, language: language)
              : AppText.string(.battery, language: language)
          )
        } currentValueLabel: {
          Text("\(batteryLevel)%")
        }
      }

      Divider()

      HStack(spacing: 12) {
        Button {
          do {
            hapticEngine = try GameControllerRuntime.playHaptic(on: controller)
            hapticError = nil
          } catch {
            hapticEngine = nil
            hapticError = AppText.formatted(
              .controllerHapticsFailed,
              language: language,
              error.localizedDescription
            )
          }
        } label: {
          Label(
            AppText.string(.controllerTestHaptics, language: language),
            systemImage: "waveform"
          )
        }
        .disabled(!snapshot.hasHaptics)

        Text(
          AppText.string(
            snapshot.hasHaptics ? .controllerHapticsAvailable : .controllerHapticsUnavailable,
            language: language
          )
        )
        .font(.caption)
        .foregroundStyle(.secondary)
      }

      if let hapticError {
        Text(hapticError)
          .font(.caption)
          .foregroundStyle(.red)
      }

      if snapshot.hasLight {
        VStack(alignment: .leading, spacing: 8) {
          Label(AppText.string(.controllerLight, language: language), systemImage: "lightbulb")
            .font(.headline)

          colorSlider(.lightingRed, value: $red)
          colorSlider(.lightingGreen, value: $green)
          colorSlider(.lightingBlue, value: $blue)

          Button {
            _ = GameControllerRuntime.setLight(
              on: controller,
              red: Float(red),
              green: Float(green),
              blue: Float(blue)
            )
          } label: {
            Label(
              AppText.string(.lightingApplyColor, language: language),
              systemImage: "paintpalette"
            )
          }
        }
      }

      Label(
        AppText.string(
          snapshot.hasRemappedElements
            ? .controllerSystemMappingActive
            : .controllerSystemMappingDefault,
          language: language
        ),
        systemImage: "arrow.triangle.swap"
      )
      .font(.caption)
      .foregroundStyle(.secondary)
    }
  }

  private func colorSlider(_ key: AppStringKey, value: Binding<Double>) -> some View {
    HStack {
      Text(AppText.string(key, language: language))
        .frame(width: 64, alignment: .leading)
      Slider(value: value, in: 0...1)
      Text(Int(value.wrappedValue * 255), format: .number)
        .monospacedDigit()
        .frame(width: 38, alignment: .trailing)
    }
  }
}
