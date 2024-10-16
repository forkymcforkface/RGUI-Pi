- RGUI-Pi is an advanced CRT only RGUI implementation using rtomasa Retroarch [Dynares](https://github.com/forkymcforkface/RetroArch/edit/master/dynaresinfo.md) for pixel perfect gaming. 
- It also has the ability to migrate rtomasa OS4 from the original image to the Pi Zero2, Pi3 and Pi5. This utilizes no changes to the original OS4 code as OS4 ui is closed source.
   - This is unsupported and please dont ask the rgbpi devs for support. The primary function of this image is Pi5 with minimal to no testing on other Pi's
------------------------
**How to Migrate OS4 to Pi5**
- Download the [latest release](https://github.com/forkymcforkface/RGUI-Pi/releases) and burn to an SD card, insert into the Pi5
- Download [OS4](https://www.rgb-pi.com/#os) and burn to a normal USB drive (not sd card), insert into Pi5 USB port.
- Turn on the Pi5 and wait for that migration to complete (about 2mins)
- Here is a [video of the process](https://youtu.be/CJom1TIRI6g) 
- You Must use [this specific USB audio DAC](https://a.co/d/2eTi2mp) if you want audio in the OS4 UI, I can't guarantee others will work as OS4 is hard coded to the hardware device 'headphones' 

------------------------
**How to change settings for different hats, cables**
- After migrating OS4 scan for games with just the sd card. Open ports and there are options there to change to
 - Lo-tech 24bit vga888 (also supports retrotink ultimate)
 - VGA666 (does not display full 18bit colors)
 - RGB-Pi cable (full 18bit color)
- You must run the pi zero2 Pi3 script if you are running on those systems.
- USB Audio Dac required even for Pi Zero2, Pi3, Pi4. Can probably be fixed, but pi5 is the focus. 
------------------------
Build Sources
- Debian Bookworm: [raspios_lite_arm64-2024-07-04](https://downloads.raspberrypi.com/raspios_lite_arm64/images/)
- Python Version: 3.9.2
- RetroArch: [RetroArch](https://github.com/forkymcforkface/RetroArch)
- GPIO Video driver: [rpi-dpidac](https://github.com/forkymcforkface/rpi-dpidac)
- Jamma Driver: [JammaPi](https://github.com/forkymcforkface/JammaPi)
- Guncon Driver: [guncon2](https://github.com/rtomasa/guncon2)
- xone Driver: [xone](https://github.com/forkymcforkface/xone)
------------------------


*Self Install** (Work in progress, do not use)
   - Download the latest [Bookworm release](https://downloads.raspberrypi.com/raspios_lite_arm64/images/)
   - Plug into Pi5
   - Get IP address
   - SSH Login as pi user
   - Run the below command and sit back until RGUI-Pi appears
   ```markdown
   sudo apt install git -y && git clone --depth=1 https://github.com/forkymcforkface/RGUI-Pi.git && cd RGUI-Pi && chmod +x Install-RGUI.sh && ./Install-RGUI.sh
   ```
--------------------
 
**Things to Note**
- Interlacing is not possible with gpio on pi5
- Kodi disabled (do not use)
- The OS4 UI is half the frames and feels slow, its an incompatibility with OS4 UI and the Pi5 hardware. I cannot fix this since the UI is closed source.
- If using a pi3 or pi zero2 make sure to scan for games after the first os4 boot, go to ports and apply the pi3/zero2 timings patch.
- pi pw: rguipi
