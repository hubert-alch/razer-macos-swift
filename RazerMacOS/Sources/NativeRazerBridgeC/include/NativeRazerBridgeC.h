#ifndef NATIVE_RAZER_BRIDGE_C_H
#define NATIVE_RAZER_BRIDGE_C_H

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

int NativeRazerRefreshDevices(NativeRazerDeviceSnapshot *snapshots, int maxSnapshots);
int NativeRazerRefreshMice(NativeRazerMouseSnapshot *snapshots, int maxSnapshots);
int NativeRazerSetMouseDPI(int internalDeviceId, unsigned short dpi);
int NativeRazerSetMousePollingRate(int internalDeviceId, unsigned short pollingRate);
int NativeRazerIsGameControllerProductId(unsigned short productId);
void NativeRazerShutdown(void);

#ifdef __cplusplus
}
#endif

#endif
