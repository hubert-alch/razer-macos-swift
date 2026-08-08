import AppKit
import NativeRazerCore
import SwiftUI

@MainActor
final class NativeAppModel {
  static let shared = NativeAppModel()

  let store = NativeDeviceStore()
  private var mainWindow: NSWindow?

  private init() {}

  func showMainWindow() {
    if let existingWindow = mainWindow ?? NSApp.windows.first(where: { $0.title == windowTitle }) {
      mainWindow = existingWindow
      existingWindow.title = windowTitle
      existingWindow.makeKeyAndOrderFront(nil)
      NSApp.activate(ignoringOtherApps: true)
      return
    }

    let window = mainWindow ?? makeMainWindow()
    mainWindow = window

    if !window.isVisible {
      window.center()
    }
    window.makeKeyAndOrderFront(nil)
    NSApp.activate(ignoringOtherApps: true)
  }

  func refreshDevices() {
    store.refresh()
  }

  func showAboutPanel() {
    let language = AppLanguage.stored(
      from: UserDefaults.standard.string(forKey: AppLanguage.storageKey)
    )
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
      ?? "0.4.18"
    let credits = NSAttributedString(
      string: AppText.string(.aboutCredits, language: language)
    )

    NSApp.orderFrontStandardAboutPanel(options: [
      .applicationName: AppText.string(.appTitle, language: language),
      .applicationVersion: version,
      .version: AppText.string(.appBuildDescription, language: language),
      .credits: credits
    ])
    NSApp.activate(ignoringOtherApps: true)
  }

  func shutdown() {
    store.shutdown()
  }

  private func makeMainWindow() -> NSWindow {
    let rootView = ContentView(store: store)
      .frame(minWidth: 860, minHeight: 540)

    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 960, height: 680),
      styleMask: [.titled, .closable, .miniaturizable, .resizable],
      backing: .buffered,
      defer: false
    )
    window.title = windowTitle
    window.contentView = NSHostingView(rootView: rootView)
    window.isReleasedWhenClosed = false
    window.setFrameAutosaveName("RazerMacOSMainWindow")
    return window
  }

  private var windowTitle: String {
    let language = AppLanguage.stored(
      from: UserDefaults.standard.string(forKey: AppLanguage.storageKey)
    )
    return AppText.string(.appTitle, language: language)
  }
}
