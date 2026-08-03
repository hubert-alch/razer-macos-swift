#include "NativeRazerBridgeC.h"

#include <stdbool.h>
#include <stdlib.h>

#include "razerdevice.h"
#include "razermouse_driver.h"

extern bool is_mouse(IOUSBDeviceInterface **usb_dev);
extern bool is_keyboard(IOUSBDeviceInterface **usb_dev);
extern bool is_mouse_dock(IOUSBDeviceInterface **usb_dev);
extern bool is_mouse_mat(IOUSBDeviceInterface **usb_dev);
extern bool is_egpu(IOUSBDeviceInterface **usb_dev);
extern bool is_headphone(IOUSBDeviceInterface **usb_dev);
extern bool is_accessory(IOUSBDeviceInterface **usb_dev);
extern bool is_game_controller(IOUSBDeviceInterface **usb_dev);
extern int razer_gc_xinput_open(void);
extern int razer_gc_xinput_poll(RazerGamepadState *state, int timeoutMs);
extern int razer_gc_xinput_rumble(uint8_t left, uint8_t right);
extern int razer_gc_xinput_led(uint8_t pattern);
extern void razer_gc_xinput_close(void);
extern int razer_gc_parse_360(const uint8_t *data, int len, RazerGamepadState *state);
extern int razer_gc_parse_gip(const uint8_t *data, int len, RazerGamepadState *state);

enum {
  NATIVE_RAZER_KIND_ACCESSORY = 0,
  NATIVE_RAZER_KIND_EGPU = 1,
  NATIVE_RAZER_KIND_HEADPHONE = 2,
  NATIVE_RAZER_KIND_KEYBOARD = 3,
  NATIVE_RAZER_KIND_MOUSE = 4,
  NATIVE_RAZER_KIND_MOUSE_DOCK = 5,
  NATIVE_RAZER_KIND_MOUSE_MAT = 6,
  NATIVE_RAZER_KIND_GAME_CONTROLLER = 7,
  NATIVE_RAZER_KIND_UNKNOWN = 8
};

static RazerDevices cached_devices = {0};
static bool has_cached_devices = false;

static void close_cached_devices(void) {
  if (has_cached_devices) {
    closeAllRazerDevices(cached_devices);
    cached_devices.devices = NULL;
    cached_devices.size = 0;
    has_cached_devices = false;
  }
}

static RazerDevice *find_cached_device(int internalDeviceId) {
  if (!has_cached_devices) {
    cached_devices = getAllRazerDevices();
    has_cached_devices = true;
  }

  for (int index = 0; index < cached_devices.size; ++index) {
    if (cached_devices.devices[index].internalDeviceId == internalDeviceId) {
      return &cached_devices.devices[index];
    }
  }

  return NULL;
}

static int device_kind_for(IOUSBDeviceInterface **usbDevice) {
  if (is_mouse(usbDevice)) {
    return NATIVE_RAZER_KIND_MOUSE;
  }
  if (is_keyboard(usbDevice)) {
    return NATIVE_RAZER_KIND_KEYBOARD;
  }
  if (is_mouse_dock(usbDevice)) {
    return NATIVE_RAZER_KIND_MOUSE_DOCK;
  }
  if (is_mouse_mat(usbDevice)) {
    return NATIVE_RAZER_KIND_MOUSE_MAT;
  }
  if (is_egpu(usbDevice)) {
    return NATIVE_RAZER_KIND_EGPU;
  }
  if (is_headphone(usbDevice)) {
    return NATIVE_RAZER_KIND_HEADPHONE;
  }
  if (is_accessory(usbDevice)) {
    return NATIVE_RAZER_KIND_ACCESSORY;
  }
  if (is_game_controller(usbDevice)) {
    return NATIVE_RAZER_KIND_GAME_CONTROLLER;
  }
  return NATIVE_RAZER_KIND_UNKNOWN;
}

int NativeRazerIsGameControllerProductId(unsigned short productId) {
  return is_game_controller_product_id(productId) ? 1 : 0;
}

// The gamepad state persists across polls so that GIP input reports keep the
// Guide bit reported by the separate virtual key report.
static RazerGamepadState xinput_persistent_state = {0};

static NativeRazerGamepadState native_state_from(const RazerGamepadState *raw) {
  NativeRazerGamepadState state = {0};
  state.buttons = raw->buttons;
  state.leftTrigger = raw->leftTrigger;
  state.rightTrigger = raw->rightTrigger;
  state.leftX = raw->leftX;
  state.leftY = raw->leftY;
  state.rightX = raw->rightX;
  state.rightY = raw->rightY;
  state.lastReportTimeMs = raw->lastReportTimeMs;
  return state;
}

static RazerGamepadState razer_state_from(const NativeRazerGamepadState *state) {
  RazerGamepadState raw = {0};
  raw.buttons = state->buttons;
  raw.leftTrigger = state->leftTrigger;
  raw.rightTrigger = state->rightTrigger;
  raw.leftX = state->leftX;
  raw.leftY = state->leftY;
  raw.rightX = state->rightX;
  raw.rightY = state->rightY;
  raw.lastReportTimeMs = state->lastReportTimeMs;
  return raw;
}

int NativeRazerXInputOpen(void) {
  return razer_gc_xinput_open();
}

int NativeRazerXInputPoll(NativeRazerGamepadState *state, int timeoutMs) {
  if (state == NULL) {
    return -1;
  }

  int result = razer_gc_xinput_poll(&xinput_persistent_state, timeoutMs);
  if (result > 0) {
    *state = native_state_from(&xinput_persistent_state);
  }
  return result;
}

int NativeRazerXInputRumble(uint8_t left, uint8_t right) {
  return razer_gc_xinput_rumble(left, right);
}

int NativeRazerXInputLed(uint8_t pattern) {
  return razer_gc_xinput_led(pattern);
}

void NativeRazerXInputClose(void) {
  razer_gc_xinput_close();
  RazerGamepadState zeroed = {0};
  xinput_persistent_state = zeroed;
}

void NativeRazerXInputParse360(const uint8_t *data, int len, NativeRazerGamepadState *state) {
  if (state == NULL) {
    return;
  }
  RazerGamepadState raw = razer_state_from(state);
  razer_gc_parse_360(data, len, &raw);
  *state = native_state_from(&raw);
}

void NativeRazerXInputParseGip(const uint8_t *data, int len, NativeRazerGamepadState *state) {
  if (state == NULL) {
    return;
  }
  RazerGamepadState raw = razer_state_from(state);
  razer_gc_parse_gip(data, len, &raw);
  *state = native_state_from(&raw);
}

int NativeRazerRefreshDevices(NativeRazerDeviceSnapshot *snapshots, int maxSnapshots) {
  if (snapshots == NULL || maxSnapshots <= 0) {
    return 0;
  }

  close_cached_devices();
  cached_devices = getAllRazerDevices();
  has_cached_devices = true;

  int count = 0;
  for (int index = 0; index < cached_devices.size && count < maxSnapshots; ++index) {
    RazerDevice *device = &cached_devices.devices[index];
    if (device->usbDevice == NULL) {
      continue;
    }

    NativeRazerDeviceSnapshot snapshot = {0};
    snapshot.internalDeviceId = device->internalDeviceId;
    snapshot.productId = device->productId;
    snapshot.deviceKind = device_kind_for(device->usbDevice);
    snapshots[count] = snapshot;
    count += 1;
  }

  return count;
}

int NativeRazerRefreshMice(NativeRazerMouseSnapshot *snapshots, int maxSnapshots) {
  if (snapshots == NULL || maxSnapshots <= 0) {
    return 0;
  }

  if (!has_cached_devices) {
    cached_devices = getAllRazerDevices();
    has_cached_devices = true;
  }

  int count = 0;
  for (int index = 0; index < cached_devices.size && count < maxSnapshots; ++index) {
    RazerDevice *device = &cached_devices.devices[index];
    if (device->usbDevice == NULL || !is_mouse(device->usbDevice)) {
      continue;
    }

    NativeRazerMouseSnapshot snapshot = {0};
    snapshot.internalDeviceId = device->internalDeviceId;
    snapshot.productId = device->productId;
    snapshot.dpi = razer_attr_read_dpi(device->usbDevice);
    snapshot.pollingRate = razer_attr_read_poll_rate(device->usbDevice);

    char batteryBuffer[4] = {0};
    razer_attr_read_get_battery(device->usbDevice, batteryBuffer);
    int rawBattery = atoi(batteryBuffer);
    snapshot.batteryLevel = rawBattery > 0 ? (rawBattery * 100) / 255 : -1;

    char chargingBuffer[2] = {0};
    razer_attr_read_is_charging(device->usbDevice, chargingBuffer);
    snapshot.charging = atoi(chargingBuffer) > 0 ? 1 : 0;

    snapshots[count] = snapshot;
    count += 1;
  }

  return count;
}

int NativeRazerSetMouseDPI(int internalDeviceId, unsigned short dpi) {
  RazerDevice *device = find_cached_device(internalDeviceId);
  if (device == NULL || device->usbDevice == NULL) {
    return -1;
  }

  razer_attr_write_dpi(device->usbDevice, dpi, dpi);
  return 0;
}

int NativeRazerSetMousePollingRate(int internalDeviceId, unsigned short pollingRate) {
  RazerDevice *device = find_cached_device(internalDeviceId);
  if (device == NULL || device->usbDevice == NULL) {
    return -1;
  }

  razer_attr_write_poll_rate(device->usbDevice, pollingRate);
  return 0;
}

void NativeRazerShutdown(void) {
  close_cached_devices();
}
