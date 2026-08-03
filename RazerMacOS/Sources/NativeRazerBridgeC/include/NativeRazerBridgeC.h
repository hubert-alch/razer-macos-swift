#ifndef NATIVE_RAZER_BRIDGE_C_H
#define NATIVE_RAZER_BRIDGE_C_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  int internalDeviceId;
  unsigned short productId;
  int deviceKind;
} NativeRazerDeviceSnapshot;

typedef struct {
  int internalDeviceId;
  unsigned short productId;
  unsigned short dpi;
  unsigned short pollingRate;
  int batteryLevel;
  int charging;
} NativeRazerMouseSnapshot;

typedef struct {
  uint16_t buttons;
  uint8_t leftTrigger;
  uint8_t rightTrigger;
  int16_t leftX;
  int16_t leftY;
  int16_t rightX;
  int16_t rightY;
  uint64_t lastReportTimeMs;
} NativeRazerGamepadState;

enum {
  NativeRazerGPButtonA = 1 << 0,
  NativeRazerGPButtonB = 1 << 1,
  NativeRazerGPButtonX = 1 << 2,
  NativeRazerGPButtonY = 1 << 3,
  NativeRazerGPButtonLB = 1 << 4,
  NativeRazerGPButtonRB = 1 << 5,
  NativeRazerGPButtonView = 1 << 6,
  NativeRazerGPButtonMenu = 1 << 7,
  NativeRazerGPButtonGuide = 1 << 8,
  NativeRazerGPButtonL3 = 1 << 9,
  NativeRazerGPButtonR3 = 1 << 10,
  NativeRazerGPButtonDpadUp = 1 << 11,
  NativeRazerGPButtonDpadDown = 1 << 12,
  NativeRazerGPButtonDpadLeft = 1 << 13,
  NativeRazerGPButtonDpadRight = 1 << 14
};

int NativeRazerRefreshDevices(NativeRazerDeviceSnapshot *snapshots, int maxSnapshots);
int NativeRazerRefreshMice(NativeRazerMouseSnapshot *snapshots, int maxSnapshots);
int NativeRazerSetMouseDPI(int internalDeviceId, unsigned short dpi);
int NativeRazerSetMousePollingRate(int internalDeviceId, unsigned short pollingRate);
int NativeRazerIsGameControllerProductId(unsigned short productId);
int NativeRazerXInputOpen(void);
int NativeRazerXInputPoll(NativeRazerGamepadState *state, int timeoutMs);
int NativeRazerXInputRumble(uint8_t left, uint8_t right);
int NativeRazerXInputLed(uint8_t pattern);
void NativeRazerXInputClose(void);
void NativeRazerXInputParse360(const uint8_t *data, int len, NativeRazerGamepadState *state);
void NativeRazerXInputParseGip(const uint8_t *data, int len, NativeRazerGamepadState *state);
void NativeRazerShutdown(void);

#ifdef __cplusplus
}
#endif

#endif
