- RGUI-Pi is an advanced CRT only RGUI implementation using rtomasa Retroarch Dynares for pixel perfect gaming. 
- It also has the ability to migrate rtomasa OS4 from the original image to the Pi Zero2, Pi3 and Pi5. This utilizes no changes to the original OS4 code as OS4 ui is closed source.
   - This is unsupported and please dont ask the rgbpi devs for support. The primary function of this image is Pi5 with minimal to no testing on other Pi's
------------------------
**How to Migrate OS4 to Pi5**
- Download the [latest release](https://github.com/forkymcforkface/RGUI-Pi/releases) and burn to an SD card using your favorite utility.
- Burn OS4 onto a normal USB drive, or take your Pi4 OS4 SD card and insert it into the pi5 using a SD to USB adapter.
- Turn on the Pi5 and wait for that migration to complete (about 2mins)
- Here is a video of the process https://youtu.be/CJom1TIRI6g
- You Must use this specific USB audio DAC if you want audio in the UI, I can't guarantee others will work as OS4 is hard coded to the hardware device 'headphones'(https://a.co/d/2eTi2mp) 


------------------------
Build Sources
- Debian Bookworm: https://www.raspberrypi.com/news/bookworm-the-new-version-of-raspberry-pi-os/
- Python Version: 3.9.2
- RetroArch: https://github.com/rtomasa/RetroArch
- GPIO Video driver: https://github.com/rtomasa/rpi-dpidac
- Jamma Driver: https://github.com/rtomasa/JammaPi
- Guncon Driver: https://github.com/rtomasa/guncon2
------------------------


*Self Install** (Work in progress)
   - https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit
   - Plug into Pi5
   - Get IP address
   - SSH Login as pi user
   - Run the below command and sit back until the OS4 UI appears
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
