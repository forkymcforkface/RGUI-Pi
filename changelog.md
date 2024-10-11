# Changelog

## V1
- **RGUI-Pi** launches directly to RGUI for users seeking a raw gaming experience with **ALL** available options.

## V2
- **OS4 Migration Utility**:
  - Created a utility that migrates the rgbpi application from an OS4 burned USB drive.
- **Autostart Script**:
  - Modified to launch different versions of RetroArch depending on your CRT type:
    - 15kHz RetroArch Dynares now halves the height of any game over 380, so interlacing (480i) is not required.
    - 15/31kHz: Normal RetroArch behavior as Calamity/Dynares will select 240p or 480p automatically.
- **RetroArch Overrides**:
  - Overrides applied directly in `retroarch.c`, utilizing `/media/sd/gameconfig/sys_override`.
  - Applied audio settings overrides to optimize USB audio.
- **Cores Configuration**:
  - Optimized `cores.cfg` for Pi 5 by disabling threaded video in cores that support it.

## V3
- **Kernel Headers**:
  - Refactored the image to restore kernel headers, which were previously removed, causing issues with compiling drivers.

## V4
- **DPI24 (VGA888) HAT Support**:
  - Added support for Lotek DPI24 (VGA888) HAT, with the driver available for installation via OS4 UI in `/media/sd/ports/GPIO_Device`.
- **VGA Monitor Support**:
  - Added VGA monitor scripts to `/media/sd/ports/tools` for using VGA monitors.
