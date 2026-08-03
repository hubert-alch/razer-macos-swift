import CoreHaptics
import GameController
import NativeRazerBridgeC
import NativeRazerCore
import SwiftUI

/// View-side state for the XInput direct-read path. The blocking USB poll
/// runs on a detached task (never the main thread); successful reports are
/// throttled to ~30 Hz before they reach the view. Unplug errors tear the
/// connection down and a once-per-second retry task reopens it, so replug
/// recovers on its own.
@Observable
@MainActor
final class XInputControllerModel {
  private(set) var connection: XInputConnection?
  private(set) var latestState = NativeRazerGamepadState()
  private(set) var ledPattern = 0

  private var pollTask: Task<Void, Never>?
  private var retryTask: Task<Void, Never>?

  func start() {
    guard pollTask == nil, retryTask == nil else {
      return
    }

    if open() {
      startPolling()
    } else {
      scheduleRetry()
    }
  }

  func stop() {
    retryTask?.cancel()
    retryTask = nil

    let task = pollTask
    pollTask = nil
    task?.cancel()

    let hadConnection = connection != nil
    connection = nil
    guard hadConnection else {
      return
    }

    if let task {
      // Close only after the poll loop has exited, so Close cannot race an
      // in-flight ReadPipeTO on the same interface.
      Task.detached {
        _ = await task.result
        XInputControllerRuntime.disconnect()
      }
    } else {
      XInputControllerRuntime.disconnect()
    }
  }

  func rumbleTest() {
    XInputControllerRuntime.rumbleTest()
  }

  func nextLedPattern() {
    ledPattern = XInputControllerRuntime.ledNext()
  }

  private func open() -> Bool {
    guard let connection = XInputControllerRuntime.connect() else {
      return false
    }
    self.connection = connection
    return true
  }

  private func scheduleRetry() {
    retryTask = Task { [weak self] in
      while !Task.isCancelled {
        try? await Task.sleep(for: .seconds(1))
        guard !Task.isCancelled, let self else {
          return
        }
        if self.open() {
          self.startPolling()
          return
        }
      }
    }
  }

  private func startPolling() {
    pollTask = Task.detached { [weak self] in
      var lastPublishMs: UInt64 = 0
      while !Task.isCancelled {
        switch XInputControllerRuntime.poll(timeoutMs: 100) {
        case .report(let state):
          let nowMs = XInputControllerRuntime.nowMs()
          guard nowMs >= lastPublishMs, nowMs - lastPublishMs >= 33 else {
            continue
          }
          lastPublishMs = nowMs
          await MainActor.run { [weak self] in
            self?.latestState = state
          }
        case .timeout:
          continue
        case .error:
          await MainActor.run { [weak self] in
            self?.handlePollError()
          }
          return
        }
      }
    }
  }

  private func handlePollError() {
    guard connection != nil else {
      return
    }
    connection = nil
    XInputControllerRuntime.disconnect()
    scheduleRetry()
  }
}

struct GameControllerControlsView: View {
  let deviceName: String
  let usbConnected: Bool

  @State private var red = 0.0
  @State private var green = 1.0
  @State private var blue = 0.0
  @State private var hapticEngine: CHHapticEngine?
  @State private var hapticError: String?
  @State private var xinputModel = XInputControllerModel()
  @Environment(\.appLanguage) private var language

  var body: some View {
    TimelineView(.periodic(from: .now, by: 1.0 / 30.0)) { _ in
      content
    }
    .onAppear {
      xinputModel.start()
    }
    .onDisappear {
      xinputModel.stop()
    }
  }

  @ViewBuilder
  private var content: some View {
    if let connection = xinputModel.connection {
      xinputSurface(connection: connection)
    } else if let controller = GameControllerRuntime.matchingController(
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
  private func xinputSurface(connection: XInputConnection) -> some View {
    let state = xinputModel.latestState
    let snapshot = XInputControllerRuntime.snapshot(from: state)
    let stale = XInputControllerRuntime.isStale(
      state, nowMs: XInputControllerRuntime.nowMs()
    )

    VStack(alignment: .leading, spacing: 18) {
      HStack(alignment: .firstTextBaseline) {
        Label(
          AppText.string(.controllerInputMonitor, language: language),
          systemImage: "gamecontroller.fill"
        )
        .font(.headline)

        Spacer()

        Text(
          "\(AppText.string(.controllerSourceXInputDirect, language: language)) · \(xinputProtocolName(connection))"
        )
        .font(.caption)
        .foregroundStyle(.secondary)
      }

      if stale {
        Label(
          AppText.string(.controllerXInputNoInput, language: language),
          systemImage: "exclamationmark.triangle"
        )
        .font(.caption)
        .foregroundStyle(.orange)
      }

      Text(AppText.string(.controllerPressToTest, language: language))
        .font(.caption)
        .foregroundStyle(.secondary)

      buttonsGrid(snapshot.buttons)
      padsSection(snapshot.pads)

      Divider()

      HStack(spacing: 12) {
        Button {
          xinputModel.rumbleTest()
        } label: {
          Label(
            AppText.string(.controllerTestHaptics, language: language),
            systemImage: "waveform"
          )
        }
        .disabled(!snapshot.hasHaptics)
      }

      if snapshot.hasLight {
        VStack(alignment: .leading, spacing: 8) {
          Label(AppText.string(.controllerLight, language: language), systemImage: "lightbulb")
            .font(.headline)

          HStack(spacing: 12) {
            Button {
              xinputModel.nextLedPattern()
            } label: {
              Label(
                AppText.string(.controllerLedNextPattern, language: language),
                systemImage: "lightbulb.led"
              )
            }

            Text(String(format: "0x%02X", xinputModel.ledPattern))
              .monospacedDigit()
              .foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private func xinputProtocolName(_ connection: XInputConnection) -> String {
    AppText.string(
      connection.protocolCode == XInputConnection.protocolGip
        ? .controllerProtocolXboxOneGip
        : .controllerProtocolXbox360,
      language: language
    )
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

      buttonsGrid(snapshot.buttons)
      padsSection(snapshot.pads)

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

  @ViewBuilder
  private func buttonsGrid(_ buttons: [GameControllerButtonSnapshot]) -> some View {
    if !buttons.isEmpty {
      LazyVGrid(
        columns: [GridItem(.adaptive(minimum: 150), spacing: 8)],
        alignment: .leading,
        spacing: 8
      ) {
        ForEach(buttons) { button in
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
  }

  @ViewBuilder
  private func padsSection(_ pads: [GameControllerPadSnapshot]) -> some View {
    if !pads.isEmpty {
      VStack(alignment: .leading, spacing: 8) {
        Text(AppText.string(.controllerAxes, language: language))
          .font(.headline)

        ForEach(pads) { pad in
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
