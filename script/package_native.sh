#!/usr/bin/env bash
set -euo pipefail

APP_NAME="RazerMacOS"
DISPLAY_NAME="Razer macOS"
APP_BUNDLE_NAME="$DISPLAY_NAME.app"
BUNDLE_ID="com.w2ysw3m.RazerMacOS"
MIN_SYSTEM_VERSION="14.0"
APP_VERSION="${APP_VERSION:-0.4.15}"
SIGNING_MODE="${MACOS_SIGNING_MODE:-auto}"
SIGN_IDENTITY="${MACOS_CODESIGN_IDENTITY:-}"
NOTARIZE="${MACOS_NOTARIZE:-0}"
NATIVE_MACOS_ARCHS="${NATIVE_MACOS_ARCHS:-arm64 x86_64}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$ROOT_DIR/RazerMacOS"
DIST_ROOT="$ROOT_DIR/dist"
DIST_DIR="$DIST_ROOT/release"
BUILD_DIR="$DIST_ROOT/native-release"
APP_BUNDLE="$BUILD_DIR/$APP_BUNDLE_NAME"
DMG_STAGING_DIR="$BUILD_DIR/dmg-staging"
APP_CONTENTS="$APP_BUNDLE/Contents"
APP_MACOS="$APP_CONTENTS/MacOS"
APP_RESOURCES="$APP_CONTENTS/Resources"
APP_BINARY="$APP_MACOS/$APP_NAME"
INFO_PLIST="$APP_CONTENTS/Info.plist"
ICON_SOURCE="$ROOT_DIR/resources/icon.icns"
ICON_NAME="AppIcon.icns"
ZIP_PATH="$DIST_DIR/$APP_NAME-$APP_VERSION-macOS.zip"
DMG_PATH="$DIST_DIR/$APP_NAME-$APP_VERSION-macOS.dmg"
DMG_RW_PATH="$DIST_DIR/$APP_NAME-$APP_VERSION-macOS-rw.dmg"
NOTARY_ZIP="$DIST_DIR/$APP_NAME-$APP_VERSION-notary.zip"
CHECKSUM_PATH="$DIST_DIR/SHA256SUMS.txt"

usage() {
  cat >&2 <<USAGE
usage: APP_VERSION=0.4.15 MACOS_SIGNING_MODE=auto|required|adhoc|none ./script/package_native.sh

Environment:
  APP_VERSION                 Release version written into Info.plist and artifact names.
  MACOS_SIGNING_MODE          auto, required, adhoc, or none. Default: auto.
  MACOS_CODESIGN_IDENTITY     Signing identity name. Developer ID Application is preferred.
  MACOS_NOTARIZE              1 to notarize with notarytool. Default: 0.
  NATIVE_MACOS_ARCHS          Space-separated architectures. Default: arm64 x86_64.
  APPLE_API_KEY_PATH          Path to AuthKey_*.p8 when MACOS_NOTARIZE=1.
  APPLE_API_KEY_ID            App Store Connect API key id when MACOS_NOTARIZE=1.
  APPLE_API_ISSUER_ID         App Store Connect issuer id when MACOS_NOTARIZE=1.
USAGE
}

find_signing_identity() {
  security find-identity -p codesigning -v | awk -F '"' '/Developer ID Application/ { print $2; exit }'
}

resolve_signing_identity() {
  case "$SIGNING_MODE" in
    none)
      echo ""
      ;;
    adhoc)
      echo "-"
      ;;
    required)
      if [[ -z "$SIGN_IDENTITY" ]]; then
        SIGN_IDENTITY="$(find_signing_identity)"
      fi
      if [[ -z "$SIGN_IDENTITY" ]]; then
        echo "Developer ID Application identity is required when MACOS_SIGNING_MODE=required." >&2
        exit 1
      fi
      echo "$SIGN_IDENTITY"
      ;;
    auto)
      if [[ -n "$SIGN_IDENTITY" ]]; then
        echo "$SIGN_IDENTITY"
        return
      fi
      local identity
      identity="$(find_signing_identity)"
      if [[ -n "$identity" ]]; then
        echo "$identity"
      else
        echo "-"
      fi
      ;;
    -h|--help|help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown MACOS_SIGNING_MODE: $SIGNING_MODE" >&2
      usage
      exit 2
      ;;
  esac
}

write_info_plist() {
  cat >"$INFO_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key>
  <string>$APP_NAME</string>
  <key>CFBundleIdentifier</key>
  <string>$BUNDLE_ID</string>
  <key>CFBundleName</key>
  <string>$DISPLAY_NAME</string>
  <key>CFBundleDisplayName</key>
  <string>$DISPLAY_NAME</string>
  <key>CFBundleIconFile</key>
  <string>AppIcon</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>$APP_VERSION</string>
  <key>CFBundleVersion</key>
  <string>$APP_VERSION</string>
  <key>LSMinimumSystemVersion</key>
  <string>$MIN_SYSTEM_VERSION</string>
  <key>GCSupportsControllerUserInteraction</key>
  <true/>
  <key>NSPrincipalClass</key>
  <string>NSApplication</string>
</dict>
</plist>
PLIST
}

sign_path() {
  local path="$1"
  local identity="$2"

  if [[ -z "$identity" ]]; then
    echo "Skipping codesign for $path"
    return
  fi

  local args=(--force --deep --strict --sign "$identity")
  if [[ "$identity" != "-" ]]; then
    args+=(--options runtime --timestamp)
  fi

  local attempt
  for attempt in 1 2 3; do
    if codesign "${args[@]}" "$path"; then
      return
    fi

    if [[ "$attempt" == "3" ]]; then
      return 1
    fi

    echo "codesign failed for $path; retrying in 5 seconds..." >&2
    sleep 5
  done
}

verify_signed_path() {
  local path="$1"
  local identity="$2"

  if [[ -z "$identity" ]]; then
    echo "Skipping codesign verification for unsigned artifact: $path"
    return
  fi

  codesign --verify --deep --strict --verbose=2 "$path"
}

notarize_path() {
  local path="$1"
  local identity="$2"

  if [[ "$NOTARIZE" != "1" ]]; then
    return
  fi

  if [[ -z "$identity" || "$identity" == "-" ]]; then
    echo "Notarization requires a Developer ID Application signing identity." >&2
    exit 1
  fi

  if [[ -z "${APPLE_API_KEY_PATH:-}" || -z "${APPLE_API_KEY_ID:-}" || -z "${APPLE_API_ISSUER_ID:-}" ]]; then
    echo "APPLE_API_KEY_PATH, APPLE_API_KEY_ID, and APPLE_API_ISSUER_ID are required when MACOS_NOTARIZE=1." >&2
    exit 1
  fi

  xcrun notarytool submit "$path" \
    --key "$APPLE_API_KEY_PATH" \
    --key-id "$APPLE_API_KEY_ID" \
    --issuer "$APPLE_API_ISSUER_ID" \
    --wait
}

create_zip() {
  local output="$1"
  rm -f "$output"
  ditto -c -k --norsrc --noextattr --keepParent "$APP_BUNDLE" "$output"
}

create_dmg_background() {
  local output="$1"

  swift - "$output" <<'SWIFT'
import AppKit

let output = CommandLine.arguments[1]
let size = NSSize(width: 640, height: 400)
let image = NSImage(size: size)

image.lockFocus()

NSColor(calibratedRed: 0.08, green: 0.09, blue: 0.09, alpha: 1).setFill()
NSBezierPath(rect: NSRect(origin: .zero, size: size)).fill()

let titleParagraph = NSMutableParagraphStyle()
titleParagraph.alignment = .center
let titleAttributes: [NSAttributedString.Key: Any] = [
  .font: NSFont.systemFont(ofSize: 30, weight: .semibold),
  .foregroundColor: NSColor(calibratedWhite: 0.96, alpha: 1),
  .paragraphStyle: titleParagraph
]
"Install Razer macOS".draw(
  in: NSRect(x: 0, y: 320, width: size.width, height: 42),
  withAttributes: titleAttributes
)

let bodyAttributes: [NSAttributedString.Key: Any] = [
  .font: NSFont.systemFont(ofSize: 16, weight: .regular),
  .foregroundColor: NSColor(calibratedWhite: 0.72, alpha: 1),
  .paragraphStyle: titleParagraph
]
"Drag the app to Applications".draw(
  in: NSRect(x: 0, y: 292, width: size.width, height: 28),
  withAttributes: bodyAttributes
)

let arrowColor = NSColor(calibratedRed: 0.30, green: 0.92, blue: 0.46, alpha: 1)
arrowColor.setStroke()
let arrow = NSBezierPath()
arrow.move(to: NSPoint(x: 260, y: 180))
arrow.line(to: NSPoint(x: 382, y: 180))
arrow.lineWidth = 5
arrow.lineCapStyle = .round
arrow.stroke()

let arrowHead = NSBezierPath()
arrowHead.move(to: NSPoint(x: 382, y: 180))
arrowHead.line(to: NSPoint(x: 362, y: 194))
arrowHead.move(to: NSPoint(x: 382, y: 180))
arrowHead.line(to: NSPoint(x: 362, y: 166))
arrowHead.lineWidth = 5
arrowHead.lineCapStyle = .round
arrowHead.stroke()

let captionAttributes: [NSAttributedString.Key: Any] = [
  .font: NSFont.systemFont(ofSize: 13, weight: .medium),
  .foregroundColor: NSColor(calibratedWhite: 0.78, alpha: 1),
  .paragraphStyle: titleParagraph
]
"Razer macOS.app".draw(
  in: NSRect(x: 70, y: 70, width: 200, height: 24),
  withAttributes: captionAttributes
)
"Applications".draw(
  in: NSRect(x: 370, y: 70, width: 200, height: 24),
  withAttributes: captionAttributes
)

image.unlockFocus()

guard
  let tiff = image.tiffRepresentation,
  let bitmap = NSBitmapImageRep(data: tiff),
  let png = bitmap.representation(using: .png, properties: [:])
else {
  fatalError("Could not render DMG background")
}

try png.write(to: URL(fileURLWithPath: output))
SWIFT
}

prepare_dmg_staging() {
  rm -rf "$DMG_STAGING_DIR"
  mkdir -p "$DMG_STAGING_DIR/.background"
  ditto "$APP_BUNDLE" "$DMG_STAGING_DIR/$APP_BUNDLE_NAME"
  ln -s /Applications "$DMG_STAGING_DIR/Applications"
  create_dmg_background "$DMG_STAGING_DIR/.background/background.png"
}

configure_dmg_finder_layout() {
  local mount_dir="$1"

  osascript <<APPLESCRIPT
tell application "Finder"
  set mountedFolder to (POSIX file "$mount_dir" as alias)
  open mountedFolder
  delay 1
  set targetWindow to front window
  set current view of targetWindow to icon view
  set toolbar visible of targetWindow to false
  set statusbar visible of targetWindow to false
  set bounds of targetWindow to {100, 100, 740, 500}
  set viewOptions to icon view options of targetWindow
  set arrangement of viewOptions to not arranged
  set icon size of viewOptions to 96
  set background picture of viewOptions to (POSIX file "$mount_dir/.background/background.png" as alias)
  set position of item "$APP_BUNDLE_NAME" of mountedFolder to {170, 210}
  set position of item "Applications" of mountedFolder to {470, 210}
  update mountedFolder without registering applications
  delay 1
  close targetWindow
end tell
APPLESCRIPT
}

create_dmg() {
  local mount_dir

  rm -f "$DMG_PATH" "$DMG_RW_PATH"
  prepare_dmg_staging

  hdiutil create \
    -volname "$DISPLAY_NAME" \
    -srcfolder "$DMG_STAGING_DIR" \
    -ov \
    -fs HFS+ \
    -format UDRW \
    "$DMG_RW_PATH"

  mount_dir="$(mktemp -d)"
  hdiutil attach "$DMG_RW_PATH" -readwrite -noverify -noautoopen -mountpoint "$mount_dir" >/dev/null
  if ! configure_dmg_finder_layout "$mount_dir"; then
    echo "Warning: Finder DMG layout configuration failed; continuing with default layout." >&2
  fi
  sync
  hdiutil detach "$mount_dir" -quiet
  rmdir "$mount_dir"

  hdiutil convert "$DMG_RW_PATH" \
    -format UDZO \
    -imagekey zlib-level=9 \
    -o "$DMG_PATH"
  rm -f "$DMG_RW_PATH"
}

main() {
  rm -rf "$BUILD_DIR" "$DIST_DIR"
  mkdir -p "$APP_MACOS" "$APP_RESOURCES" "$DIST_DIR"

  local build_args=(-c release --package-path "$PACKAGE_DIR")
  local arch
  for arch in $NATIVE_MACOS_ARCHS; do
    build_args+=(--arch "$arch")
  done

  swift build "${build_args[@]}"
  local build_binary
  build_binary="$(swift build "${build_args[@]}" --show-bin-path)/$APP_NAME"
  cp "$build_binary" "$APP_BINARY"
  chmod +x "$APP_BINARY"
  cp "$ICON_SOURCE" "$APP_RESOURCES/$ICON_NAME"
  lipo -info "$APP_BINARY"
  write_info_plist

  local identity
  identity="$(resolve_signing_identity)"
  sign_path "$APP_BUNDLE" "$identity"
  verify_signed_path "$APP_BUNDLE" "$identity"

  if [[ "$NOTARIZE" == "1" ]]; then
    create_zip "$NOTARY_ZIP"
    notarize_path "$NOTARY_ZIP" "$identity"
    xcrun stapler staple "$APP_BUNDLE"
    rm -f "$NOTARY_ZIP"
  fi

  create_zip "$ZIP_PATH"
  create_dmg
  sign_path "$DMG_PATH" "$identity"
  verify_signed_path "$DMG_PATH" "$identity"
  notarize_path "$DMG_PATH" "$identity"
  if [[ "$NOTARIZE" == "1" ]]; then
    xcrun stapler staple "$DMG_PATH"
  fi

  (
    cd "$DIST_DIR"
    shasum -a 256 "$(basename "$ZIP_PATH")" "$(basename "$DMG_PATH")" >"$CHECKSUM_PATH"
  )

  echo "Artifacts:"
  echo "  $ZIP_PATH"
  echo "  $DMG_PATH"
  echo "  $CHECKSUM_PATH"
}

main "$@"
